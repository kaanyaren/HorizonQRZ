abstract class LogUploadService {
  String get platformId;
  String get platformName;

  Future<bool> authenticate(Map<String, String> credentials);
  Future<bool> uploadQso(dynamic qso, {Map<String, String>? credentials});
  Future<bool> uploadBatch(List<dynamic> qsos, {Map<String, String>? credentials});
  Future<Map<String, dynamic>> getStatus({Map<String, String>? credentials});
}

class UploadResult {
  final bool success;
  final String? remoteId;
  final String? error;

  UploadResult({
    required this.success,
    this.remoteId,
    this.error,
  });
}
