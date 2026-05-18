import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../services/qrz_xml_service.dart';
import '../services/qrz_logbook_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final qrzXmlServiceProvider = Provider<QrzXmlService>((ref) {
  return QrzXmlService();
});

final qrzLogbookServiceProvider = Provider<QrzLogbookService>((ref) {
  return QrzLogbookService();
});

class AuthNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setAuthenticated(bool value) {
    state = value;
  }
}

final authStateProvider = NotifierProvider<AuthNotifier, bool>(AuthNotifier.new);
