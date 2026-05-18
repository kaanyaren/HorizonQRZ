import 'package:dio/dio.dart';
import 'package:xml/xml.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class QrzXmlService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://xmldata.qrz.com/xml/current/'));
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  String? _sessionKey;
  static const String agent = 'HorizonQRZ-v1.0';

  Future<String?> login(String username, String password) async {
    try {
      final response = await _dio.get('', queryParameters: {
        'username': username,
        'password': password,
        'agent': agent,
      });

      final document = XmlDocument.parse(response.data);
      final key = document.findAllElements('Key').firstOrNull?.innerText;
      
      if (key != null && key.isNotEmpty) {
        _sessionKey = key;
        await _secureStorage.write(key: 'qrz_session_key', value: key);
        // Store credentials for auto-relogin
        await _secureStorage.write(key: 'qrz_username', value: username);
        await _secureStorage.write(key: 'qrz_password', value: password);
        return key;
      } else {
        final error = document.findAllElements('Error').firstOrNull?.innerText;
        throw Exception(error ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> lookup(String callsign, {bool isRetry = false}) async {
    if (_sessionKey == null) {
      _sessionKey = await _secureStorage.read(key: 'qrz_session_key');
    }

    if (_sessionKey == null) {
      // Try to re-login if we have stored credentials
      final username = await _secureStorage.read(key: 'qrz_username');
      final password = await _secureStorage.read(key: 'qrz_password');
      if (username != null && password != null) {
        await login(username, password);
      } else {
        throw Exception('No active session and no stored credentials');
      }
    }

    try {
      final response = await _dio.get('', queryParameters: {
        's': _sessionKey,
        'callsign': callsign,
      });

      final document = XmlDocument.parse(response.data);
      
      // Check for session errors
      final error = document.findAllElements('Error').firstOrNull?.innerText;
      if (error != null && (error.contains('Session Timeout') || error.contains('Invalid session')) && !isRetry) {
        _sessionKey = null;
        return lookup(callsign, isRetry: true);
      }

      final callbook = document.findAllElements('Callsign').firstOrNull;

      if (callbook != null) {
        return {
          'call': callbook.findElements('call').firstOrNull?.innerText,
          'fname': callbook.findElements('fname').firstOrNull?.innerText,
          'name': callbook.findElements('name').firstOrNull?.innerText,
          'addr1': callbook.findElements('addr1').firstOrNull?.innerText,
          'addr2': callbook.findElements('addr2').firstOrNull?.innerText,
          'state': callbook.findElements('state').firstOrNull?.innerText,
          'country': callbook.findElements('country').firstOrNull?.innerText,
          'image': callbook.findElements('image').firstOrNull?.innerText,
          'qslmgr': callbook.findElements('qslmgr').firstOrNull?.innerText,
        };
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
