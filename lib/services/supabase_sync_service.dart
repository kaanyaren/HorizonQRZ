import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/app_database.dart';

class SyncResult {
  final bool success;
  final int pushedCount;
  final int pulledCount;
  final DateTime? lastSyncTime;
  final String? error;

  SyncResult({
    required this.success,
    required this.pushedCount,
    required this.pulledCount,
    this.lastSyncTime,
    this.error,
  });
}

class SupabaseSyncService {
  final AppDatabase _localDb;
  late final SupabaseClient _client;

  SupabaseSyncService(this._localDb) {
    _client = Supabase.instance.client;
  }

  /// Direction: Local → Supabase
  Future<SyncResult> pushLocalChanges() async {
    try {
      final pendingQsos = await (_localDb.select(_localDb.localQsos)
        ..where((t) => t.syncStatus.equals('pending_upload'))).get();

      if (pendingQsos.isEmpty) {
        return SyncResult(success: true, pushedCount: 0, pulledCount: 0, lastSyncTime: DateTime.now());
      }

      int pushedCount = 0;
      for (final qso in pendingQsos) {
        try {
          await _client.from('qsos').upsert({
            'id': qso.id,
            'user_id': qso.userUuid,
            'callsign': qso.callsign,
            'qso_date': qso.qsoDate.toIso8601String().split('T')[0],
            'time_on': qso.timeOn,
            'band': qso.band,
            'mode': qso.mode,
            'freq': qso.freq,
            'rst_sent': qso.rstSent,
            'rst_rcvd': qso.rstRcvd,
            'name': qso.name,
            'qth': qso.qth,
            'country': qso.country,
            'gridsquare': qso.gridsquare,
            'lat': qso.lat,
            'lon': qso.lon,
            'comment': qso.comment,
            'prop_mode': qso.propMode,
            'sat_name': qso.satName,
            'tx_pwr': qso.txPwr,
            'my_sig': qso.mySig,
            'sig': qso.sig,
            'state': qso.state,
            'cq_zone': qso.cqz,
            'contest_id': qso.contestId,
            'stx': qso.stx,
            'srx': qso.srx,
            'stx_string': qso.stxString,
            'srx_string': qso.srxString,
            'station_callsign': qso.stationCallsign,
            'operator': qso.operator,
          });

          // Mark as synced locally
          await (_localDb.update(_localDb.localQsos)
            ..where((t) => t.id.equals(qso.id))).write(
            const LocalQsosCompanion(syncStatus: Value('synced')),
          );
          pushedCount++;
        } catch (e) {
          print('Push error: $e');
        }
      }

      return SyncResult(success: true, pushedCount: pushedCount, pulledCount: 0, lastSyncTime: DateTime.now());
    } catch (e) {
      return SyncResult(success: false, pushedCount: 0, pulledCount: 0, error: e.toString());
    }
  }

  /// Direction: Supabase → Local
  Future<SyncResult> pullRemoteChanges() async {
    try {
      final user = await _client.auth.currentUser;
      if (user == null) {
        return SyncResult(success: false, pushedCount: 0, pulledCount: 0, error: 'Not authenticated');
      }

      // Fetch from Supabase
      final remoteQsos = await _client
          .from('qsos')
          .select()
          .eq('user_id', user.id)
          .order('updated_at', ascending: true);

      if (remoteQsos.isEmpty) {
        return SyncResult(success: true, pushedCount: 0, pulledCount: 0, lastSyncTime: DateTime.now());
      }

      int pulledCount = 0;
      for (final remoteQso in remoteQsos) {
        try {
          final remoteId = remoteQso['id'].toString();

          // Check if QSO exists in local DB
          final localQsos = await (_localDb.select(_localDb.localQsos)
            ..where((t) => t.supabaseId.equals(remoteId))).get();

          if (localQsos.isEmpty) {
            // Insert from remote
            await _localDb.into(_localDb.localQsos).insert(LocalQsosCompanion.insert(
              id: remoteId,
              callsign: remoteQso['callsign'].toString(),
              userUuid: remoteQso['user_id'].toString(),
              supabaseId: remoteId,
              qsoDate: DateTime.parse(remoteQso['qso_date'].toString()),
              timeOn: remoteQso['time_on']?.toString() ?? '000000',
              band: remoteQso['band'].toString(),
              mode: remoteQso['mode'].toString(),
              freq: Value(remoteQso['freq']?.toString()),
              rstSent: Value(remoteQso['rst_sent']?.toString()),
              rstRcvd: Value(remoteQso['rst_rcvd']?.toString()),
              name: Value(remoteQso['name']?.toString()),
              qth: Value(remoteQso['qth']?.toString()),
              country: Value(remoteQso['country']?.toString()),
              gridsquare: Value(remoteQso['gridsquare']?.toString()),
              lat: Value(remoteQso['lat']?.toString()),
              lon: Value(remoteQso['lon']?.toString()),
              comment: Value(remoteQso['comment']?.toString()),
              propMode: Value(remoteQso['prop_mode']?.toString()),
              satName: Value(remoteQso['sat_name']?.toString()),
              txPwr: Value(remoteQso['tx_pwr']?.toString()),
              mySig: Value(remoteQso['my_sig']?.toString()),
              sig: Value(remoteQso['sig']?.toString()),
              state: Value(remoteQso['state']?.toString()),
              cqz: Value(remoteQso['cq_zone']?.toString()),
              contestId: Value(remoteQso['contest_id']?.toString()),
              stx: Value(remoteQso['stx']?.toString()),
              srx: Value(remoteQso['srx']?.toString()),
              stxString: Value(remoteQso['stx_string']?.toString()),
              srxString: Value(remoteQso['srx_string']?.toString()),
              stationCallsign: remoteQso['station_callsign']?.toString() ?? '',
              stationGridsquare: Value(remoteQso['station_gridsquare']?.toString()),
              operator: Value(remoteQso['operator']?.toString()),
              syncStatus: 'synced',
              syncVersion: 0,
            ));
            pulledCount++;
          }
        } catch (e) {
          print('Pull error: $e');
        }
      }

      return SyncResult(success: true, pushedCount: 0, pulledCount: pulledCount, lastSyncTime: DateTime.now());
    } catch (e) {
      return SyncResult(success: false, pushedCount: 0, pulledCount: 0, error: e.toString());
    }
  }

  /// Full two-way sync (push then pull)
  Future<SyncResult> syncAll() async {
    try {
      final user = await _client.auth.currentUser;
      if (user == null) {
        return SyncResult(success: false, pushedCount: 0, pulledCount: 0, error: 'Not authenticated');
      }

      final pushResult = await pushLocalChanges();
      final pullResult = await pullRemoteChanges();
      return SyncResult(
        success: pushResult.success && pullResult.success,
        pushedCount: pushResult.pushedCount,
        pulledCount: pullResult.pulledCount,
        lastSyncTime: pushResult.lastSyncTime,
      );
    } catch (e) {
      return SyncResult(success: false, pushedCount: 0, pulledCount: 0, error: e.toString());
    }
  }
}
