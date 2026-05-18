import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../utils/adif_parser.dart';
import 'app_providers.dart';

enum SyncPhase { idle, fetching, parsing, syncing, completed, error }

class SyncState {
  final SyncPhase phase;
  final int current;
  final int total;
  final String? error;

  SyncState({
    this.phase = SyncPhase.idle,
    this.current = 0,
    this.total = 0,
    this.error,
  });

  SyncState copyWith({
    SyncPhase? phase,
    int? current,
    int? total,
    String? error,
  }) {
    return SyncState(
      phase: phase ?? this.phase,
      current: current ?? this.current,
      total: total ?? this.total,
      error: error ?? this.error,
    );
  }
}

class SyncNotifier extends Notifier<SyncState> {
  @override
  SyncState build() {
    _init();
    return SyncState();
  }

  void _init() {
    Connectivity().onConnectivityChanged.listen((results) {
      if (results.any((result) => result != ConnectivityResult.none)) {
        syncPendingQsos();
      }
    });
  }

  Future<void> _log(String message, {String level = 'info', String? details}) async {
    final db = ref.read(databaseProvider);
    await db.into(db.syncLogs).insert(SyncLogsCompanion.insert(
      timestamp: DateTime.now(),
      level: level,
      message: message,
      details: Value(details),
    ));
  }

  Future<void> syncPendingQsos() async {
    final db = ref.read(databaseProvider);
    final logbookService = ref.read(qrzLogbookServiceProvider);
    
    final settings = await (db.select(db.appSettings)..limit(1)).getSingleOrNull();
    if (settings == null || settings.logbookApiKey == null) return;

    final pendingQsos = await (db.select(db.qsos)..where((t) => t.syncStatus.equals('pending'))).get();

    if (pendingQsos.isNotEmpty) {
      await _log('Starting sync of ${pendingQsos.length} pending QSOs');
    }

    for (final qso in pendingQsos) {
      try {
        final adif = qso.rawAdif ?? _convertToAdif(qso, settings.qrzUsername ?? '');
        final result = await logbookService.insertQso(settings.logbookApiKey!, adif);

        if (result['RESULT'] == 'OK') {
          await (db.update(db.qsos)..where((t) => t.id.equals(qso.id))).write(
            QsosCompanion(
              qrzLogid: Value(result['LOGID']),
              syncStatus: const Value('synced'),
            ),
          );
        } else if (result['RESULT'] == 'AUTH') {
          await _log('Auth error during QSO upload', level: 'error', details: result['REASON']);
          ref.read(notificationProvider.notifier).notify(
            'QRZ Logbook authentication failed. Please check your API key.',
            title: 'Sync Error',
            isError: true,
          );
          break;
        } else {
          await (db.update(db.qsos)..where((t) => t.id.equals(qso.id))).write(
            const QsosCompanion(syncStatus: Value('error')),
          );
          await _log('Failed to upload QSO for ${qso.callsign}', level: 'error', details: result['REASON']);
        }
      } catch (e) {
        await _log('Network error during QSO upload', level: 'error', details: e.toString());
      }
    }
  }

  Future<bool> fetchAndSyncAllLogs() async {
    state = state.copyWith(phase: SyncPhase.fetching, current: 0, total: 0);
    await _log('Starting full logbook fetch');
    
    final db = ref.read(databaseProvider);
    final logbookService = ref.read(qrzLogbookServiceProvider);
    
    final settings = await (db.select(db.appSettings)..limit(1)).getSingleOrNull();
    if (settings == null || settings.logbookApiKey == null) {
      state = state.copyWith(phase: SyncPhase.error, error: 'Missing API Key');
      await _log('Fetch failed: Missing API Key', level: 'error');
      return false;
    }

    try {
      final adif = await logbookService.fetchLog(settings.logbookApiKey!);
      
      if (adif.isEmpty) {
        state = state.copyWith(phase: SyncPhase.completed);
        await _log('Fetch completed: No records found');
        return true;
      }

      state = state.copyWith(phase: SyncPhase.parsing);
      final records = await compute(AdifParser.parse, adif);
      
      state = state.copyWith(phase: SyncPhase.syncing, total: records.length);
      await _log('Parsing completed, syncing ${records.length} records');

      const batchSize = 100;
      int importedCount = 0;
      int updatedCount = 0;
      int existingCount = 0;

      for (int i = 0; i < records.length; i += batchSize) {
        final end = (i + batchSize < records.length) ? i + batchSize : records.length;
        final batch = records.sublist(i, end);

        await db.transaction(() async {
          for (final record in batch) {
            final logId = record['QRZLOGID'] ?? record['APP_QRZLOG_LOGID'];
            final callsign = record['CALL'] ?? 'UNKNOWN';
            final dateStr = record['QSO_DATE'] ?? '';
            final timeStr = record['TIME_ON'] ?? '000000';
            final band = record['BAND'] ?? 'N/A';
            final mode = record['MODE'] ?? 'N/A';

            Qso? existing;
            if (logId != null) {
              existing = await (db.select(db.qsos)..where((t) => t.qrzLogid.equals(logId))).getSingleOrNull();
            }

            if (existing == null) {
              final qsoDate = _parseAdifDateTime(dateStr, timeStr);
              existing = await (db.select(db.qsos)
                ..where((t) => 
                  t.callsign.equals(callsign) & 
                  t.qsoDate.equals(qsoDate) & 
                  t.band.equals(band) & 
                  t.mode.equals(mode)
                )).getSingleOrNull();
            }

            if (existing != null && existing.syncStatus == 'pending') {
              if (existing.qrzLogid == null && logId != null) {
                await (db.update(db.qsos)..where((t) => t.id.equals(existing!.id))).write(
                  QsosCompanion(qrzLogid: Value(logId)),
                );
              }
              existingCount++;
              continue; 
            }

            if (existing == null) {
              final qsoDate = _parseAdifDateTime(dateStr, timeStr);
              await db.into(db.qsos).insert(
                QsosCompanion.insert(
                  qrzLogid: Value(logId),
                  callsign: callsign,
                  qsoDate: qsoDate,
                  band: band,
                  mode: mode,
                  rstSent: Value(record['RST_SENT']),
                  rstRcvd: Value(record['RST_RCVD']),
                  syncStatus: const Value('synced'),
                  rawAdif: Value(record.toString()),
                  name: Value(record['NAME']),
                  qth: Value(record['QTH']),
                  country: Value(record['COUNTRY']),
                  gridsquare: Value(record['GRIDSQUARE']),
                  lat: Value(record['LAT']),
                  lon: Value(record['LON']),
                  comment: Value(record['COMMENT']),
                  freq: Value(record['FREQ']),
                  state: Value(record['STATE']),
                  cqz: Value(record['CQZ']),
                ),
              );
              importedCount++;
            } else {
              await (db.update(db.qsos)..where((t) => t.id.equals(existing!.id))).write(
                QsosCompanion(
                  qrzLogid: Value(logId),
                  name: Value(record['NAME']),
                  qth: Value(record['QTH']),
                  country: Value(record['COUNTRY']),
                  gridsquare: Value(record['GRIDSQUARE']),
                  lat: Value(record['LAT']),
                  lon: Value(record['LON']),
                  comment: Value(record['COMMENT']),
                  freq: Value(record['FREQ']),
                  state: Value(record['STATE']),
                  cqz: Value(record['CQZ']),
                  syncStatus: const Value('synced'),
                ),
              );
              updatedCount++;
            }
          }
        });
        
        state = state.copyWith(current: i + batch.length);
      }
      
      await (db.update(db.appSettings)).write(
        AppSettingsCompanion(lastSyncTimestamp: Value(DateTime.now())),
      );
      
      state = state.copyWith(phase: SyncPhase.completed);
      await _log('Full sync completed. Imported: $importedCount, Updated: $updatedCount');
      return true;
    } catch (e, stack) {
      print('DEBUG: Sync error: $e');
      state = state.copyWith(phase: SyncPhase.error, error: e.toString());
      await _log('Full sync failed', level: 'error', details: e.toString());
      
      if (e.toString().contains('AUTH')) {
        ref.read(notificationProvider.notifier).notify(
          'QRZ Logbook authentication failed. Please check your API key.',
          title: 'Sync Error',
          isError: true,
        );
      }
      return false;
    }
  }

  DateTime _parseAdifDateTime(String dateStr, String timeStr) {
    try {
      if (dateStr.length == 8) {
        final y = int.parse(dateStr.substring(0, 4));
        final m = int.parse(dateStr.substring(4, 6));
        final d = int.parse(dateStr.substring(6, 8));
        final hh = int.parse(timeStr.substring(0, 2));
        final mm = int.parse(timeStr.substring(2, 4));
        final ss = timeStr.length >= 6 ? int.parse(timeStr.substring(4, 6)) : 0;
        return DateTime.utc(y, m, d, hh, mm, ss);
      }
    } catch (e) {
      // Fallback
    }
    return DateTime.now().toUtc();
  }

  String _convertToAdif(Qso qso, String myCall) {
    final dateStr = qso.qsoDate.toIso8601String().split('T')[0].replaceAll('-', '');
    final timeStr = qso.qsoDate.toIso8601String().split('T')[1].replaceAll(':', '').split('.')[0];
    
    String adif = '<CALL:${qso.callsign.length}>${qso.callsign} '
           '<BAND:${qso.band.length}>${qso.band} '
           '<MODE:${qso.mode.length}>${qso.mode} '
           '<QSO_DATE:8>$dateStr '
           '<TIME_ON:6>$timeStr '
           '<STATION_CALLSIGN:${myCall.length}>$myCall ';
    
    if (qso.freq != null && qso.freq!.isNotEmpty) {
      adif += '<FREQ:${qso.freq!.length}>${qso.freq} ';
    }
    
    return '$adif<EOR>';
  }
}

final syncProvider = NotifierProvider<SyncNotifier, SyncState>(SyncNotifier.new);
