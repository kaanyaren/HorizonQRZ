// AWARDS PROVIDER - Stub (needs QRZ XML integration)
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AwardsNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void refreshAwards() {
    // TODO: Query QRZ XML for awards
  }
}

final awardsProvider = NotifierProvider<AwardsNotifier, int>(AwardsNotifier.new);
