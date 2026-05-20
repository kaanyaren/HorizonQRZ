import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  /// Try compile-time defines first, fall back to defaults for dev builds.
  /// For production, pass via: --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
  static const _defaultUrl = 'https://api.logsummit.samuel.com.tr';
  static const _defaultAnonKey = 'eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJyb2xlIjogImFub24iLCAiaXNzIjogInN1cGFiYXNlIiwgImlhdCI6IDE3Nzc4ODA3MjksICJleHAiOiAxOTM1NTYwNzI5fQ.1mGcwoDmtpXWZYm7yj4abCcaPpIoTuL2OO3Ym7f9ZiQ';

  static late final String _supabaseUrl;
  static late final String _anonKey;

  static Future<void> initialize() async {
    _supabaseUrl = const String.fromEnvironment('SUPABASE_URL');
    _anonKey = const String.fromEnvironment('SUPABASE_ANON_KEY');

    if (_supabaseUrl.isEmpty) {
      if (kDebugMode) {
        debugPrint('SUPABASE_URL not set via --dart-define, using default');
      }
    }
    if (_anonKey.isEmpty) {
      if (kDebugMode) {
        debugPrint('SUPABASE_ANON_KEY not set via --dart-define, using default');
      }
    }

    await Supabase.initialize(
      url: _supabaseUrl.isNotEmpty ? _supabaseUrl : _defaultUrl,
      anonKey: _anonKey.isNotEmpty ? _anonKey : _defaultAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;

  // Helper to access log_summit schema
  static PostgrestQueryBuilder get qsos =>
      client.schema('log_summit').from('qsos');
  static PostgrestQueryBuilder get profiles =>
      client.schema('log_summit').from('profiles');
  static PostgrestQueryBuilder get platformCredentials =>
      client.schema('log_summit').from('platform_credentials');
  static PostgrestQueryBuilder get uploadTrackers =>
      client.schema('log_summit').from('upload_trackers');
  
  static PostgrestQueryBuilder get syncMetadata =>
      client.schema('log_summit').from('sync_metadata');
}
