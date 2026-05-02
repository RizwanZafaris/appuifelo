import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/router/app_router.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/profile/data/profile_repository.dart';
import 'package:felo/features/profile/domain/profile_settings.dart';

class FeloApp extends ConsumerWidget {
  const FeloApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(profileSettingsNotifierProvider);
    final themeMode = settingsAsync.maybeWhen(
      data: (s) => _materialThemeMode(s.themeMode),
      orElse: () => ThemeMode.system,
    );

    return MaterialApp.router(
      title: 'Felo',
      debugShowCheckedModeBanner: false,
      theme: FeloTheme.light(),
      darkTheme: FeloTheme.dark(),
      themeMode: themeMode,
      routerConfig: appRouter,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

ThemeMode _materialThemeMode(FeloThemeMode mode) {
  return switch (mode) {
    FeloThemeMode.system => ThemeMode.system,
    FeloThemeMode.light => ThemeMode.light,
    FeloThemeMode.dark => ThemeMode.dark,
  };
}
