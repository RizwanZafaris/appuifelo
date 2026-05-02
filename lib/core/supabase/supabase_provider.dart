import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:felo/core/config/felo_env.dart';

/// Single shared SupabaseClient. Initialized in main() before runApp().
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Current auth user (null when signed out). Streams updates so the UI
/// reacts to sign-in / sign-out events.
final authStateProvider = StreamProvider<AuthState>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return client.auth.onAuthStateChange;
});

final currentSupabaseUserProvider = Provider<User?>((ref) {
  return ref
      .watch(authStateProvider)
      .maybeWhen(data: (state) => state.session?.user, orElse: () => null);
});

/// Bootstraps Supabase. Call once from main() before runApp(...).
Future<void> initSupabase() async {
  await Supabase.initialize(
    url: FeloEnv.supabaseUrl,
    anonKey: FeloEnv.supabasePublishableKey,
    debug: false,
  );
}
