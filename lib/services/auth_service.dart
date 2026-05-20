import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  /// Sign in with Google (Android).
  /// On mobile, this opens a browser for OAuth. The auth result is observed
  /// via [GoTrueClient.onAuthStateChange] (set up in AuthNotifier).
  static Future<AuthResult> signInWithGoogle() async {
    try {
      final launched = await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'supabase://auth/callback',
      );
      return AuthResult(launched: launched);
    } catch (e) {
      return AuthResult(error: e.toString());
    }
  }

  /// Sign in with Apple (iOS).
  static Future<AuthResult> signInWithApple() async {
    try {
      final launched = await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: 'supabase://auth/callback',
      );
      return AuthResult(launched: launched);
    } catch (e) {
      return AuthResult(error: e.toString());
    }
  }

  // Sign out
  static Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }

  // Get current session
  static Session? get currentSession =>
      Supabase.instance.client.auth.currentSession;

  // Get current user
  static Future<User?> getCurrentUser() async {
    return Supabase.instance.client.auth.currentUser;
  }
}

class AuthResult {
  /// Whether the OAuth URL was successfully launched (browser opened).
  final bool launched;
  final String? error;

  AuthResult({this.launched = false, this.error});
}
