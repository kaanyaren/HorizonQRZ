import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';
import '../services/supabase_sync_service.dart';
import '../database/app_database.dart';
import 'app_providers.dart';

enum AppSyncPhase { idle, pushing, pulling, syncing, completed, error }

class AppSyncState {
  final AppSyncPhase phase;
  final int localChanges;
  final int remoteChanges;
  final DateTime? lastSyncTime;
  final String? error;

  AppSyncState({
    this.phase = AppSyncPhase.idle,
    this.localChanges = 0,
    this.remoteChanges = 0,
    this.lastSyncTime,
    this.error,
  });
}

class AppSyncNotifier extends Notifier<AppSyncState> {
  late final SupabaseSyncService _syncService;

  @override
  AppSyncState build() {
    final db = ref.read(databaseProvider);
    _syncService = SupabaseSyncService(db);
    return AppSyncState();
  }

  Future<void> syncAll() async {
    state = AppSyncState(phase: AppSyncPhase.syncing);

    try {
      final result = await _syncService.syncAll();
      state = AppSyncState(
        phase: AppSyncPhase.completed,
        localChanges: result.pushedCount,
        remoteChanges: result.pulledCount,
        lastSyncTime: result.lastSyncTime,
      );
    } catch (e) {
      state = AppSyncState(
        phase: AppSyncPhase.error,
        error: e.toString(),
      );
    }
  }

  Future<void> pushLocalChanges() async {
    state = AppSyncState(phase: AppSyncPhase.pushing);
    try {
      final result = await _syncService.pushLocalChanges();
      state = AppSyncState(
        phase: result.success ? AppSyncPhase.completed : AppSyncPhase.error,
        localChanges: result.pushedCount,
        error: result.error,
      );
    } catch (e) {
      state = AppSyncState(phase: AppSyncPhase.error, error: e.toString());
    }
  }

  Future<void> pullRemoteChanges() async {
    state = AppSyncState(phase: AppSyncPhase.pulling);
    try {
      final result = await _syncService.pullRemoteChanges();
      state = AppSyncState(
        phase: result.success ? AppSyncPhase.completed : AppSyncPhase.error,
        remoteChanges: result.pulledCount,
        error: result.error,
      );
    } catch (e) {
      state = AppSyncState(phase: AppSyncPhase.error, error: e.toString());
    }
  }

  void clear() {
    state = AppSyncState();
  }
}

final appSyncProvider = NotifierProvider<AppSyncNotifier, AppSyncState>(AppSyncNotifier.new);
