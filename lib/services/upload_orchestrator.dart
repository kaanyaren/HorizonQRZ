import 'log_upload_service.dart';
import 'qrz_upload_service.dart';
import 'clublog_upload_service.dart';
import 'eqsl_upload_service.dart';

class UploadOrchestrator {
  final Map<String, LogUploadService> _services = {
    'qrz': QrzUploadService(),
    'clublog': ClubLogUploadService(),
    'eqsl': EqslUploadService(),
  };

  Map<String, Map<String, String>> _platformCredentials = {};

  void loadCredentials(Map<String, Map<String, String>> creds) {
    _platformCredentials = creds;
  }

  void saveCredentials(Map<String, Map<String, String>> creds) {
    _platformCredentials = creds;
  }

  Future<Map<String, UploadResult>> uploadQsoToAll(dynamic qso) async {
    final results = <String, UploadResult>{};

    for (final platform in _services.keys) {
      final service = _services[platform]!;
      final credentials = _platformCredentials[platform] ?? {};
      
      final result = await service.uploadQso(qso, credentials: credentials);
      results[platform] = UploadResult(
        success: result,
        remoteId: null,
        error: result ? null : 'Upload failed',
      );
    }

    return results;
  }

  Future<Map<String, UploadResult>> uploadBatchToAll(List<dynamic> qsos) async {
    final results = <String, UploadResult>{};

    for (final platform in _services.keys) {
      final service = _services[platform]!;
      final credentials = _platformCredentials[platform] ?? {};
      
      final result = await service.uploadBatch(qsos, credentials: credentials);
      results[platform] = UploadResult(
        success: result,
        remoteId: null,
        error: result ? null : 'Upload failed',
      );
    }

    return results;
  }

  Future<Map<String, Map<String, dynamic>>> getAllStatuses() async {
    final statuses = <String, Map<String, dynamic>>{};

    for (final platform in _services.keys) {
      final service = _services[platform]!;
      final credentials = _platformCredentials[platform] ?? {};
      
      final status = await service.getStatus(credentials: credentials);
      statuses[platform] = status;
    }

    return statuses;
  }
}
