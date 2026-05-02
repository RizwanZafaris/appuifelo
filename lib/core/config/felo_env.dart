import 'package:flutter/foundation.dart';

/// Build-time configuration injected via `--dart-define`.
///
/// SECURITY: never commit real credentials. Production-required values
/// default to empty strings so a release build with missing env will
/// fail fast in [assertProductionReady] — preventing accidental ship
/// with the emulator URL or fake-data flag.
class FeloEnv {
  const FeloEnv._();

  /// Backend (NestJS) base URL — must include `/v1` prefix.
  ///
  /// Default is **empty** so a release build cannot ship with the
  /// emulator URL. Local dev passes the right URL via `--dart-define`:
  ///   * Android emulator → host machine: `http://10.0.2.2:3000/v1`
  ///   * iOS simulator    → `http://localhost:3000/v1`
  ///   * Physical device  → LAN IP or staging URL (HTTPS)
  static const String apiUrl = String.fromEnvironment('FELO_API_URL', defaultValue: '');

  /// Supabase project URL.
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL', defaultValue: '');

  /// Supabase publishable (anon) key — safe to ship. Never `sb_secret_*`.
  static const String supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: '',
  );

  /// Toggle between fake repositories and real ones. Only honoured in
  /// debug/profile builds — release builds always force real repos
  /// regardless of the dart-define, so a CI typo can't ship fakes.
  static bool get useFakeData {
    if (kReleaseMode) return false;
    return _useFakeDataRaw;
  }

  static const bool _useFakeDataRaw = bool.fromEnvironment(
    'FELO_USE_FAKE_DATA',
    defaultValue: false,
  );

  /// Feature flag: 8-phase onboarding journey.
  static const bool useOnboardingV2 = bool.fromEnvironment(
    'FELO_USE_ONBOARDING_V2',
    defaultValue: false,
  );

  // ── Stub-feature flags (default OFF in release) ───────────────────
  // Stubs are never reachable in production until the backend is wired.
  // Debug/profile builds may opt in to preview the screens.

  static const bool _enableKycRaw = bool.fromEnvironment(
    'FELO_ENABLE_KYC',
    defaultValue: false,
  );
  static const bool _enableInvestmentsRaw = bool.fromEnvironment(
    'FELO_ENABLE_INVESTMENTS',
    defaultValue: false,
  );
  static const bool _enableSmsParserRaw = bool.fromEnvironment(
    'FELO_ENABLE_SMS_PARSER',
    defaultValue: false,
  );
  static const bool _enableLiveRemittanceRaw = bool.fromEnvironment(
    'FELO_ENABLE_LIVE_REMITTANCE',
    defaultValue: false,
  );

  static bool get enableKyc => _enableKycRaw;
  static bool get enableInvestments => _enableInvestmentsRaw;
  static bool get enableSmsParser => _enableSmsParserRaw;
  static bool get enableLiveRemittance => _enableLiveRemittanceRaw;

  /// Hard-fail boot if the release build is missing critical config or
  /// has an insecure URL. Called from [main] before any provider reads.
  static void assertProductionReady() {
    if (!kReleaseMode) return;
    final issues = <String>[];
    if (apiUrl.isEmpty) {
      issues.add('FELO_API_URL is empty');
    } else if (apiUrl.startsWith('http://')) {
      issues.add('FELO_API_URL is plain http:// — must be https://');
    } else if (apiUrl.contains('10.0.2.2') || apiUrl.contains('localhost')) {
      issues.add('FELO_API_URL points at emulator/localhost in a release build');
    }
    if (supabaseUrl.isEmpty || supabasePublishableKey.isEmpty) {
      issues.add('SUPABASE_URL or SUPABASE_PUBLISHABLE_KEY missing');
    }
    if (_useFakeDataRaw) {
      issues.add('FELO_USE_FAKE_DATA=true in a release build (release builds force false anyway)');
    }
    if (issues.isNotEmpty) {
      throw StateError('Felo release config error: ${issues.join('; ')}');
    }
  }
}
