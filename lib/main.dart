import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/supabase/supabase_provider.dart';
import 'package:felo/felo_app.dart';

/// Entry point with hardened error handling.
///
/// Hooks:
///   * [FlutterError.onError] — framework-level rendering / build errors
///   * [PlatformDispatcher.instance.onError] — async / platform errors
///   * [runZonedGuarded] — uncaught zone errors
///
/// In release builds all three forward to Crashlytics. In debug they go
/// to stderr — Crashlytics is initialised but not collecting in debug to
/// avoid noisy crash reports during development.
void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Hard fail at boot if the build forgot to inject the API URL — never
    // ship the emulator default to a real device.
    FeloEnv.assertProductionReady();

    // Per-screen FLAG_SECURE / iOS privacy overlay is applied by the
    // sensitive screens themselves via ScreenSecurity.enable() in
    // initState — see lib/core/security/screen_security.dart.

    // Crashlytics — initialise once, gate collection on release mode.
    try {
      await Firebase.initializeApp();
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
    } catch (e, st) {
      // Don't block app launch if Firebase config is missing — log loudly.
      // ignore: avoid_print
      debugPrint('Firebase init failed (Crashlytics disabled): $e\n$st');
    }

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      if (kDebugMode) {
        debugPrint('FlutterError: ${details.exceptionAsString()}');
      }
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      if (kDebugMode) {
        debugPrint('Uncaught platform error: $error\n$stack');
      }
      return true;
    };

    // Bootstrap Supabase before any provider reads SupabaseClient.
    await initSupabase();

    runApp(const ProviderScope(child: FeloApp()));
  }, (Object error, StackTrace stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    if (kDebugMode) {
      debugPrint('Uncaught zone error: $error\n$stack');
    }
  });
}
