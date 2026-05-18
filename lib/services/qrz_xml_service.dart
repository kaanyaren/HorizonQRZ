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
      
      if (key != null) {
        _sessionKey = key;
        await _secureStorage.write(key: 'qrz_session_key', value: key);
        return key;
      } else {
        final error = document.findAllElements('Error').firstOrNull?.innerText;
        throw Exception(error ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> lookup(String callsign) async {
    if (_sessionKey == null) {
      _sessionKey = await _secureStorage.read(key: 'qrz_session_key');
    }

    if (_sessionKey == null) throw Exception('No active session');

    try {
      final response = await _dio.get('', queryParameters: {
        's': _sessionKey,
        'callsign': callsign,
      });

      final document = XmlDocument.parse(response.data);
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
