import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/app_database.dart';
import '../utils/adif_parser.dart';
import 'qrz_logbook_service.dart';

class QrzImportResult {
  final bool success;
  final int importedCount;
  final int duplicateCount;
  final String? error;

  QrzImportResult({
    required this.success,
    this.importedCount = 0,
    this.duplicateCount = 0,
    this.error,
  });
}

class QrzImportService {
  final AppDatabase _db;
  final QrzLogbookService _qrzService;

  QrzImportService(this._db, this._qrzService);

  Future<QrzImportResult> importFromQrz(String apiKey) async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        return QrzImportResult(success: false, error: 'Not authenticated');
      }

      // 1. Fetch ADIF from QRZ
      final adif = await _qrzService.fetchLog(apiKey);
      if (adif.isEmpty) {
        return QrzImportResult(success: true, importedCount: 0);
      }

      // 2. Parse ADIF
      final records = AdifParser.parse(adif);
      if (records.isEmpty) {
        return QrzImportResult(success: true, importedCount: 0);
      }

      int importedCount = 0;
      int duplicateCount = 0;

      // 3. Process records
      for (final record in records) {
        final qrzLogId = record['QRZLOGID'];
        if (qrzLogId == null) continue;

        // Check for duplicates
        final existing = await (_db.select(_db.localQsos)
          ..where((t) => t.qrzLogId.equals(qrzLogId))).getSingleOrNull();

        if (existing != null) {
          duplicateCount++;
          continue;
        }

        // Map and Insert
        try {
          final qsoDateStr = record['QSO_DATE'] ?? '';
          if (qsoDateStr.length != 8) continue;
          
          final qsoDate = DateTime.parse(
            '${qsoDateStr.substring(0, 4)}-${qsoDateStr.substring(4, 6)}-${qsoDateStr.substring(6, 8)}'
          );

          await _db.into(_db.localQsos).insert(LocalQsosCompanion.insert(
            id: 'qrz_$qrzLogId',
            callsign: record['CALL'] ?? 'N/A',
            userUuid: user.id,
            supabaseId: 'qrz_$qrzLogId', // Use QRZ ID as Supabase ID too if not synced yet
            qrzLogId: Value(qrzLogId),
            qsoDate: qsoDate,
            timeOn: record['TIME_ON'] ?? '000000',
            band: record['BAND'] ?? 'N/A',
            mode: record['MODE'] ?? 'N/A',
            freq: Value(record['FREQ']),
            rstSent: Value(record['RST_SENT']),
            rstRcvd: Value(record['RST_RCVD']),
            name: Value(record['NAME']),
            qth: Value(record['QTH']),
            country: Value(record['COUNTRY']),
            gridsquare: Value(record['GRIDSQUARE']),
            lat: Value(record['LAT']),
            lon: Value(record['LON']),
            comment: Value(record['COMMENT']),
            propMode: Value(record['PROP_MODE']),
            satName: Value(record['SAT_NAME']),
            txPwr: Value(record['TX_PWR']),
            mySig: Value(record['MY_SIG']),
            sig: Value(record['SIG']),
            state: Value(record['STATE']),
            cqz: Value(record['CQZ']),
            contestId: Value(record['CONTEST_ID']),
            stx: Value(record['STX']),
            srx: Value(record['SRX']),
            stxString: Value(record['STX_STRING']),
            srxString: Value(record['SRX_STRING']),
            stationCallsign: record['STATION_CALLSIGN'] ?? record['MY_CALL'] ?? '',
            stationGridsquare: Value(record['MY_GRIDSQUARE']),
            operator: Value(record['OPERATOR'] ?? record['MY_CALL']),
            syncStatus: 'synced', // Mark as synced since it came from the source
            syncVersion: 0,
          ));
          importedCount++;
        } catch (e) {
          print('Error inserting QSO: $e');
        }
      }

      return QrzImportResult(
        success: true,
        importedCount: importedCount,
        duplicateCount: duplicateCount,
      );
    } catch (e) {
      return QrzImportResult(success: false, error: e.toString());
    }
  }
}
