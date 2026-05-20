import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';

enum AuthStatus { unauthenticated, authenticating, authenticated }

class AuthNotifier extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      state = data.session != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    });
    return Supabase.instance.client.auth.currentSession != null
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
  }

  Future<void> signInWithGoogle() async {
    state = AuthStatus.authenticating;
    try {
      await AuthService.signInWithGoogle();
      // Auth result is handled by onAuthStateChange listener in build()
    } catch (e) {
      state = AuthStatus.unauthenticated;
    }
  }

  Future<void> signInWithApple() async {
    state = AuthStatus.authenticating;
    try {
      await AuthService.signInWithApple();
      // Auth result is handled by onAuthStateChange listener in build()
    } catch (e) {
      state = AuthStatus.unauthenticated;
    }
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    state = AuthStatus.unauthenticated;
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthStatus>(AuthNotifier.new);
