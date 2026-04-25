import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/supabase/supabase_provider.dart';
import 'package:felo/felo_app.dart';

/// Entry point with hardened error handling.
///
/// Hooks into:
///   * [FlutterError.onError] — framework-level rendering / build errors
///   * [PlatformDispatcher.instance.onError] — async / platform errors
///   * [runZonedGuarded] — uncaught zone errors
///
/// In production this is where Crashlytics / Sentry would be wired up; for
/// now we route to debug logging so failures aren't swallowed silently.
void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      // TODO(felo): forward to Crashlytics once Firebase is wired.
      if (kDebugMode) {
        debugPrint('FlutterError: ${details.exceptionAsString()}');
      }
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      // TODO(felo): forward to Crashlytics once Firebase is wired.
      if (kDebugMode) {
        debugPrint('Uncaught platform error: $error\n$stack');
      }
      return true;
    };

    // Bootstrap Supabase before any provider reads SupabaseClient.
    await initSupabase();

    runApp(const ProviderScope(child: FeloApp()));
  }, (Object error, StackTrace stack) {
    // TODO(felo): forward to Crashlytics once Firebase is wired.
    if (kDebugMode) {
      debugPrint('Uncaught zone error: $error\n$stack');
    }
  });
}
