import 'package:dio/dio.dart';

class QrzLogbookService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://logbook.qrz.com/api',
    contentType: 'application/x-www-form-urlencoded',
    responseType: ResponseType.plain,
    headers: {
      'User-Agent': 'LogSummit/1.0',
    },
  ));

  Future<Map<String, String>> getStatus(String apiKey) async {
    try {
      final response = await _dio.post('', data: {
        'KEY': apiKey,
        'ACTION': 'STATUS',
      });

      final parsed = _parseResponse(response.data);
      // Map to keys expected by DashboardScreen
      return {
        'qso_count': parsed['COUNT'] ?? '0',
        'dxcc_count': parsed['DXCC'] ?? '0',
        'confirmed_count': parsed['CONFIRMED'] ?? '0',
        ...parsed,
      };
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

  Future<String> fetchLog(String apiKey) async {
    try {
      print('DEBUG: Sending POST to https://logbook.qrz.com/api with KEY and ACTION=FETCH');
      final response = await _dio.post('', data: {
        'KEY': apiKey,
        'ACTION': 'FETCH',
        'OPTION': 'TYPE:ADIF',
      });

      print('DEBUG: HTTP Status: ${response.statusCode}');
      print('DEBUG: Response Data Length: ${response.data?.toString().length}');
      
      final parsed = _parseResponse(response.data);
      if (parsed['RESULT'] == 'OK') {
        final adif = parsed['ADIF'];
        if (adif == null || adif.isEmpty) {
          print('DEBUG: RESULT is OK but ADIF field is empty or missing');
          print('DEBUG: Keys in response: ${parsed.keys.join(', ')}');
        }
        return adif ?? '';
      } else {
        print('DEBUG: QRZ API Error: ${parsed['REASON']}');
        throw Exception(parsed['REASON'] ?? 'Fetch failed');
      }
    } catch (e) {
      print('DEBUG: Dio Error: $e');
      rethrow;
    }
  }

  Map<String, String> _parseResponse(String data) {
    // print('DEBUG: Raw response data: $data'); // Removed to avoid log flooding
    final Map<String, String> result = {};
    
    // QRZ API responses are KEY=VALUE separated by &
    // But ADIF data can contain & and % and is often NOT properly encoded.
    
    // 1. Extract known keys using regex to avoid splitting by & inside ADIF
    final keys = ['RESULT', 'REASON', 'COUNT', 'LOGID', 'KEY', 'DXCC', 'CONFIRMED'];
    for (final key in keys) {
      final regExp = RegExp('$key=([^&]*)');
      final match = regExp.firstMatch(data);
      if (match != null) {
        try {
          result[key] = Uri.decodeComponent(match.group(1)!.replaceAll('+', ' '));
        } catch (e) {
          result[key] = match.group(1)!;
        }
      }
    }

    // 2. Extract ADIF specially as it's usually the last and largest part
    final adifIndex = data.indexOf('ADIF=');
    if (adifIndex != -1) {
      var adifValue = data.substring(adifIndex + 5);
      
      // If ADIF is not the last field, we'd need to find the next &
      final nextAmp = adifValue.indexOf('&');
      if (nextAmp != -1) {
        adifValue = adifValue.substring(0, nextAmp);
      }

      // We'll try to decode it, but if it fails (due to raw % signs), use as is.
      try {
        result['ADIF'] = Uri.decodeComponent(adifValue.replaceAll('+', ' '));
      } catch (e) {
        // If decoding fails, it's likely raw ADIF with % signs
        result['ADIF'] = adifValue;
      }
    }

    return result;
  }
}
