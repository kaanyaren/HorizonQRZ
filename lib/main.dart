import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/app_providers.dart';
import 'providers/sync_provider.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: HorizonQRZApp()));
}

class HorizonQRZApp extends ConsumerWidget {
  const HorizonQRZApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize sync service
    ref.read(syncProvider);

    return MaterialApp(
      title: 'HorizonQRZ',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
      ),
      home: const AuthWrapper(),
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
