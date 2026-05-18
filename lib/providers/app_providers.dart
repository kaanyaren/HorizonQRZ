import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
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

class AppNotification {
  final String message;
  final String? title;
  final bool isError;
  final DateTime timestamp;

  AppNotification({
    required this.message,
    this.title,
    this.isError = false,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class NotificationNotifier extends Notifier<AppNotification?> {
  @override
  AppNotification? build() => null;

  void notify(String message, {String? title, bool isError = false}) {
    state = AppNotification(message: message, title: title, isError: isError);
  }

  void clear() {
    state = null;
  }
}

final notificationProvider = NotifierProvider<NotificationNotifier, AppNotification?>(NotificationNotifier.new);

class NavigationNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setTab(int index) {
    state = index;
  }
}

final navigationProvider = NotifierProvider<NavigationNotifier, int>(NavigationNotifier.new);
