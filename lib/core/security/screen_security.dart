import 'package:flutter/foundation.dart';

/// Screen-capture protection — temporarily a no-op pending a maintained
/// FLAG_SECURE plugin.
///
/// `flutter_windowmanager 0.2.0` is discontinued and does not set the
/// AGP-required `namespace` property, so it fails the Android Gradle
/// build with AGP 8+. For soft-launch v1 demo APK, we ship the helper
/// as a no-op so callers (BiometricLockScreen, ConsentGate, future KYC
/// / OTP / remittance / app-lock screens) keep their initState +
/// dispose contract — when we land a maintained alternative
/// (`flutter_secure_screen` or a hand-rolled MethodChannel) the
/// implementation drops in here without touching call-sites.
///
/// Tracked in LAUNCH_READINESS.md as a P1 follow-up:
///   "Re-wire ScreenSecurity with a maintained Android FLAG_SECURE
///    plugin + iOS privacy overlay."
class ScreenSecurity {
  static Future<void> enable() async {
    if (kDebugMode) debugPrint('ScreenSecurity.enable: stubbed (P1)');
  }

  static Future<void> disable() async {
    if (kDebugMode) debugPrint('ScreenSecurity.disable: stubbed (P1)');
  }
}
