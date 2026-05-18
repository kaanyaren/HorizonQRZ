import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../utils/adif_parser.dart';
import 'app_providers.dart';

final syncProvider = Provider<SyncService>((ref) {
  return SyncService(ref);
});

class SyncService {
  final Ref _ref;

  SyncService(this._ref) {
    _init();
  }

  void _init() {
    Connectivity().onConnectivityChanged.listen((results) {
      if (results.any((result) => result != ConnectivityResult.none)) {
        syncPendingQsos();
      }
    });
  }

  Future<void> syncPendingQsos() async {
    final db = _ref.read(databaseProvider);
    final logbookService = _ref.read(qrzLogbookServiceProvider);
    
    // Get API Key from settings
    final settings = await (db.select(db.appSettings)..limit(1)).getSingleOrNull();
    if (settings == null || settings.logbookApiKey == null) return;

    final pendingQsos = await (db.select(db.qsos)..where((t) => t.syncStatus.equals('pending'))).get();

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
          // Handle auth error (re-login or notify user)
          break;
        } else {
          await (db.update(db.qsos)..where((t) => t.id.equals(qso.id))).write(
            const QsosCompanion(syncStatus: Value('error')),
          );
        }
      } catch (e) {
        // Log error
      }
    }
  }

  Future<void> fetchAndSyncAllLogs() async {
    print('DEBUG: Starting fetchAndSyncAllLogs');
    final db = _ref.read(databaseProvider);
    final logbookService = _ref.read(qrzLogbookServiceProvider);
    
    final settings = await (db.select(db.appSettings)..limit(1)).getSingleOrNull();
    if (settings == null || settings.logbookApiKey == null) {
      print('DEBUG: Missing settings or API key');
      return;
    }

    try {
      print('DEBUG: Requesting FETCH from QRZ...');
      final adif = await logbookService.fetchLog(settings.logbookApiKey!);
      print('DEBUG: Received ADIF from QRZ, length: ${adif.length}');
      
      final records = AdifParser.parse(adif);
      print('DEBUG: Total records parsed: ${records.length}');

      await db.transaction(() async {
        int importedCount = 0;
        for (final record in records) {
          // Some ADIFs use QRZLOGID, others APP_QRZLOG_LOGID
          final logId = record['QRZLOGID'] ?? record['APP_QRZLOG_LOGID'];
          
          if (logId == null) {
            print('DEBUG: Record missing logId: ${record['CALL']}');
            continue;
          }

          // Check if already exists
          final existing = await (db.select(db.qsos)..where((t) => t.qrzLogid.equals(logId))).getSingleOrNull();
          
          if (existing == null) {
            final dateStr = record['QSO_DATE'] ?? '';
            final timeStr = record['TIME_ON'] ?? '000000';
            
            DateTime qsoDate;
            try {
              if (dateStr.length == 8) {
                final y = int.parse(dateStr.substring(0, 4));
                final m = int.parse(dateStr.substring(4, 6));
                final d = int.parse(dateStr.substring(6, 8));
                final hh = int.parse(timeStr.substring(0, 2));
                final mm = int.parse(timeStr.substring(2, 4));
                final ss = timeStr.length >= 6 ? int.parse(timeStr.substring(4, 6)) : 0;
                qsoDate = DateTime.utc(y, m, d, hh, mm, ss);
              } else {
                qsoDate = DateTime.now().toUtc();
              }
            } catch (e) {
              qsoDate = DateTime.now().toUtc();
            }

            await db.into(db.qsos).insert(
              QsosCompanion.insert(
                qrzLogid: Value(logId),
                callsign: record['CALL'] ?? 'UNKNOWN',
                qsoDate: qsoDate,
                band: record['BAND'] ?? 'N/A',
                mode: record['MODE'] ?? 'N/A',
                rstSent: Value(record['RST_SENT']),
                rstRcvd: Value(record['RST_RCVD']),
                syncStatus: const Value('synced'),
              ),
            );
            importedCount++;
          }
        }
        print('DEBUG: Transaction complete. Imported $importedCount new records.');
      });
    } catch (e) {
      print('DEBUG: Sync error: $e');
    }
  }

  String _convertToAdif(Qso qso, String myCall) {
    final dateStr = qso.qsoDate.toIso8601String().split('T')[0].replaceAll('-', '');
    final timeStr = qso.qsoDate.toIso8601String().split('T')[1].replaceAll(':', '').split('.')[0];
    
    return '<CALL:${qso.callsign.length}>${qso.callsign} '
           '<BAND:${qso.band.length}>${qso.band} '
           '<MODE:${qso.mode.length}>${qso.mode} '
           '<QSO_DATE:8>$dateStr '
           '<TIME_ON:6>$timeStr '
           '<STATION_CALLSIGN:${myCall.length}>$myCall '
           '<EOR>';
  }
}
