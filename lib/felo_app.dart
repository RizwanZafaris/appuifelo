import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/router/app_router.dart';
import 'package:felo/core/theme/felo_theme.dart';

class FeloApp extends StatelessWidget {
  const FeloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Felo',
      debugShowCheckedModeBanner: false,
      theme: FeloTheme.light(),
      darkTheme: FeloTheme.dark(),
      themeMode: ThemeMode.dark,
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
