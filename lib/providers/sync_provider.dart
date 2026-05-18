import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
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
    if (settings?.logbookApiKey == null) return;

    final pendingQsos = await (db.select(db.qsos)..where((t) => t.syncStatus.equals('pending'))).get();

    for (final qso in pendingQsos) {
      try {
        final adif = qso.rawAdif ?? _convertToAdif(qso, settings!.qrzUsername!);
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
