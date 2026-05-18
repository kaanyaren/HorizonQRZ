import 'package:dio/dio.dart';

class QrzLogbookService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://logbook.qrz.com/api',
    contentType: 'application/x-www-form-urlencoded',
  ));

  Future<Map<String, String>> getStatus(String apiKey) async {
    try {
      final response = await _dio.post('', data: {
        'KEY': apiKey,
        'ACTION': 'STATUS',
      });

      return _parseResponse(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, String>> insertQso(String apiKey, String adif) async {
    try {
      final response = await _dio.post('', data: {
        'KEY': apiKey,
        'ACTION': 'INSERT',
        'ADIF': adif,
      });

      return _parseResponse(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> extractLog(String apiKey) async {
    try {
      final response = await _dio.post('', data: {
        'KEY': apiKey,
        'ACTION': 'EXTRACT',
      });

      final parsed = _parseResponse(response.data);
      if (parsed['RESULT'] == 'OK') {
        return parsed['ADIF'] ?? '';
      } else {
        throw Exception(parsed['REASON'] ?? 'Extract failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Map<String, String> _parseResponse(String data) {
    final Map<String, String> result = {};
    final parts = data.split('&');
    for (var part in parts) {
      final kv = part.split('=');
      if (kv.length == 2) {
        result[kv[0]] = Uri.decodeComponent(kv[1]);
      }
    }
    return result;
  }
}
