import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../database/app_database.dart';
import '../services/qrz_xml_service.dart';
import '../services/qrz_logbook_service.dart';
import '../services/qrz_import_service.dart';
import '../services/supabase_service.dart';
import '../services/supabase_sync_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final qrzXmlServiceProvider = Provider<QrzXmlService>((ref) {
  return QrzXmlService();
});

final qrzLogbookServiceProvider = Provider<QrzLogbookService>((ref) {
  return QrzLogbookService();
});

final qrzImportServiceProvider = Provider<QrzImportService>((ref) {
  final db = ref.read(databaseProvider);
  final qrzService = ref.read(qrzLogbookServiceProvider);
  return QrzImportService(db, qrzService);
});

final supabaseServiceProvider = Provider<SupabaseService>((ref) => SupabaseService());

final supabaseSyncServiceProvider = Provider<SupabaseSyncService>((ref) {
  final db = ref.watch(databaseProvider);
  return SupabaseSyncService(db);
});

final appNotificationProvider = Provider<AppNotification>((ref) {
  return AppNotification(message: '');
});

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

class LocationState {
  final double? latitude;
  final double? longitude;
  final bool loading;
  final String? error;

  const LocationState({this.latitude, this.longitude, this.loading = false, this.error});
}

class LocationNotifier extends Notifier<LocationState> {
  @override
  LocationState build() => const LocationState();

  Future<void> requestAndGetLocation() async {
    state = const LocationState(loading: true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = const LocationState(error: 'Location services disabled');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        state = const LocationState(error: 'Location permission denied');
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
      );
      state = LocationState(latitude: pos.latitude, longitude: pos.longitude);
    } catch (e) {
      state = LocationState(error: e.toString());
    }
  }
}

final locationProvider = NotifierProvider<LocationNotifier, LocationState>(LocationNotifier.new);
