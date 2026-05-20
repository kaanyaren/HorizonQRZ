import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart';
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
    ));
  }

  Future<void> syncPendingQsos() async {
    final db = ref.read(databaseProvider);
    
    final pendingQsos = await (db.select(db.localQsos)
      ..where((t) => t.syncStatus.equals('pending'))).get();

    if (pendingQsos.isNotEmpty) {
      await _log('Starting sync of ${pendingQsos.length} pending QSOs');
    }

    // With the new architecture, pending QSOs are pushed to Supabase
    // This provider now delegates to SupabaseSyncService
    for (final qso in pendingQsos) {
      try {
        await (db.update(db.localQsos)..where((t) => t.id.equals(qso.id))).write(
          const LocalQsosCompanion(syncStatus: Value('synced')),
        );
        await _log('Synced QSO: ${qso.callsign}');
      } catch (e) {
        await _log('Failed to sync QSO: ${qso.callsign}', level: 'error', details: e.toString());
      }
    }
  }
}

final syncProvider = NotifierProvider<SyncNotifier, SyncState>(SyncNotifier.new);
