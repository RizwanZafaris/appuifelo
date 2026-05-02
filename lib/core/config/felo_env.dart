/// Build-time configuration injected via `--dart-define`.
///
/// ⚠️ SECURITY: Never commit real credentials to source control.
/// All sensitive values default to empty strings so that production
/// builds will fail fast if CI forgets to inject them.
///
/// Run with overrides:
///   flutter run \
///     --dart-define=FELO_API_URL=http://10.0.2.2:3000/v1 \
///     --dart-define=SUPABASE_URL=https://your-project.supabase.co \
///     --dart-define=SUPABASE_PUBLISHABLE_KEY=sb_publishable_...
class FeloEnv {
  const FeloEnv._();

  /// Backend (NestJS) base URL — must include `/v1` prefix.
  ///
  /// • Android emulator → host machine: `10.0.2.2`
  /// • iOS simulator    → `localhost`
  /// • Physical device  → LAN IP or deployed URL
  static const String apiUrl = String.fromEnvironment(
    'FELO_API_URL',
    defaultValue: 'http://10.0.2.2:3000/v1',
  );

  /// Supabase project URL (used by supabase_flutter for Auth + Realtime).
  ///
  /// SECURITY: Must be overridden via --dart-define in CI/CD.
  /// Leaving the default empty will cause the app to fail at runtime
  /// with a clear error, preventing accidental use of dev credentials
  /// in production builds.
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );

  /// Supabase publishable (anon) key — safe to ship in mobile binaries.
  /// Never put `sb_secret_*` here.
  ///
  /// SECURITY: Must be overridden via --dart-define in CI/CD.
  static const String supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: '',
  );

  /// Toggle between fake repositories and real ones.
  ///
  /// `--dart-define=FELO_USE_FAKE_DATA=true` keeps the Phase-1 mock state
  /// (no backend required). Default: real backend.
  static const bool useFakeData = bool.fromEnvironment(
    'FELO_USE_FAKE_DATA',
    defaultValue: false,
  );

  /// Feature flag: route signup through the new 8-phase onboarding journey
  /// (`lib/features/onboarding_v2/`) instead of the legacy single-screen
  /// flow at `lib/features/onboarding/`.
  ///
  /// Default `false` until the new journey ships behind Stage 7. Both
  /// flows coexist during cutover; legacy is the safe fallback.
  /// `--dart-define=FELO_USE_ONBOARDING_V2=true`
  static const bool useOnboardingV2 = bool.fromEnvironment(
    'FELO_USE_ONBOARDING_V2',
    defaultValue: false,
  );
}
