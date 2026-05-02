import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

/// Screen-capture protection.
///
/// On Android: toggles WindowManager.LayoutParams.FLAG_SECURE which
/// blocks screenshots, screen recording, and prevents the screen from
/// appearing in the OS task switcher thumbnails.
/// On iOS: caller is responsible for the privacy overlay (see
/// `lib/core/security/privacy_overlay.dart`) since iOS doesn't expose
/// FLAG_SECURE.
///
/// Apply on KYC, OTP, MFA setup, remittance entry, and the app-lock
/// screen. Always pair `enable` in initState with `disable` in dispose.
class ScreenSecurity {
  static Future<void> enable() async {
    if (kIsWeb) return;
    if (!Platform.isAndroid) return;
    try {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('ScreenSecurity.enable: $e');
    }
  }

  static Future<void> disable() async {
    if (kIsWeb) return;
    if (!Platform.isAndroid) return;
    try {
      await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('ScreenSecurity.disable: $e');
    }
  }
}
