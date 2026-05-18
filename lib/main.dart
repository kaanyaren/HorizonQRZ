import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:particles_network/particles_network.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'providers/app_providers.dart';
import 'providers/sync_provider.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const ProviderScope(child: HorizonQRZApp()));
}

class HorizonQRZApp extends ConsumerWidget {
  const HorizonQRZApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize sync service
    ref.read(syncProvider);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'HorizonQRZ',
          theme: AppTheme.lightTheme,
          builder: (context, child) {
            return Stack(
              children: [
                // Base background color
                Container(color: const Color(0xFFF7F9FF)),
                // Particle animation
                ParticleNetwork(
                  particleCount: 80,
                  maxSpeed: 0.5,
                  maxSize: 2.0,
                  lineWidth: 1.0,
                  lineDistance: 100,
                  particleColor: const Color(0xFFE2E9F4), // Even lighter grey/blue-grey
                  lineColor: const Color(0xFFE2E9F4),
                  touchActivation: true,
                  gravityType: GravityType.none,
                ),
                if (child != null) child,
              ],
            );
          },
          home: const AuthWrapper(),
        );
      },
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);
    
    return FutureBuilder(
      future: (db.select(db.appSettings)..limit(1)).getSingleOrNull(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        
        final hasSettings = snapshot.data != null;
        if (hasSettings || ref.watch(authStateProvider)) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
