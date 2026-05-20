import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/app_database.dart';
import '../services/log_upload_service.dart';
import '../services/upload_orchestrator.dart';
import 'app_providers.dart';

enum UploadPhase { idle, uploading, completed, error }

class UploadState {
  final UploadPhase phase;
  final int current;
  final int total;
  final Map<String, int> platformProgress;
  final Map<String, String>? errors;

  UploadState({
    this.phase = UploadPhase.idle,
    this.current = 0,
    this.total = 0,
    this.platformProgress = const {},
    this.errors,
  });
}

class UploadNotifier extends Notifier<UploadState> {
  late final UploadOrchestrator _orchestrator;

  @override
  UploadState build() {
    _orchestrator = UploadOrchestrator();
    return UploadState();
  }

  Future<void> startUpload() async {
    state = UploadState(phase: UploadPhase.uploading, current: 0, total: 0);
    
    try {
      // Get credentials from Supabase
      final credentials = await _getCredentials();
      
      if (credentials.isEmpty) {
        state = UploadState(
          phase: UploadPhase.error,
          errors: {'all': 'No active platforms configured'},
        );
        return;
      }

      _orchestrator.saveCredentials(credentials);

      // Upload to all platforms
      final results = await _orchestrator.uploadBatchToAll([]);
      
      final totalPlatforms = results.length;
      final completedPlatforms = results.values.where((r) => r.success).length;
      
      final errorEntries = results.entries
          .where((e) => !e.value.success)
          .map((e) => MapEntry(e.key, e.value.error ?? ''));

      state = UploadState(
        phase: completedPlatforms == totalPlatforms
            ? UploadPhase.completed
            : UploadPhase.uploading,
        platformProgress: results.map((k, v) => MapEntry(k, v.success ? 1 : 0)),
        errors: errorEntries.isEmpty ? null : Map<String, String>.fromEntries(errorEntries),
      );
    } catch (e) {
      state = UploadState(
        phase: UploadPhase.error,
        errors: {'all': 'Upload failed: $e'},
      );
    }
  }

  Future<Map<String, Map<String, String>>> _getCredentials() async {
    final credentials = <String, Map<String, String>>{};
    
    try {
      final user = await Supabase.instance.client.auth.currentUser;
      if (user == null) return credentials;

      final creds = await Supabase.instance.client
          .from('platform_credentials')
          .select()
          .eq('user_id', user.id);

      for (final cred in creds) {
        final platform = cred['platform'].toString();
        if (cred['is_active'] == true) {
          credentials[platform] = {
            'callsign': user.email ?? '',
          };
        }
      }
    } catch (e) {
      print('Error fetching credentials: $e');
    }

    return credentials;
  }

  void reset() {
    state = UploadState();
  }
}

final uploadProvider = NotifierProvider<UploadNotifier, UploadState>(UploadNotifier.new);
