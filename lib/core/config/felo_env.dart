/// Build-time configuration injected via `--dart-define`.
///
/// Run with overrides:
///   flutter run \
///     --dart-define=FELO_API_URL=http://10.0.2.2:3000/v1 \
///     --dart-define=SUPABASE_URL=https://xetosbkkjowlspfxffoj.supabase.co \
///     --dart-define=SUPABASE_PUBLISHABLE_KEY=sb_publishable_...
///
/// Defaults below point at the dev Supabase project + Android-emulator
/// loopback. Production builds should override every value via CI.
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
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://xetosbkkjowlspfxffoj.supabase.co',
  );

  /// Supabase publishable (anon) key — safe to ship in mobile binaries.
  /// Never put `sb_secret_*` here.
  static const String supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: 'sb_publishable_Gp5pDHYMML1658kptTOMcQ_O-pUQVAt',
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
