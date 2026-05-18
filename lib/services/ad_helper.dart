import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2567226079694753/7848447886';
    } else if (Platform.isIOS) {
      // Assuming the user wants to use the same unit ID for iOS if they didn't provide a separate one,
      // but usually they are different. I'll use the provided one for now.
      return 'ca-app-pub-2567226079694753/7848447886';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
