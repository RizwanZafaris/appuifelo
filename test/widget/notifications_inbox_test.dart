import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/notifications/presentation/notifications_screen.dart';

void main() {
  testWidgets('notifications can be filtered and marked read', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: _NotificationsTestApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Budget alert'), findsOneWidget);
    expect(find.text('3 unread'), findsOneWidget);

    await tester.tap(find.text('Mark read').first);
    await tester.pumpAndSettle();

    expect(find.text('2 unread'), findsOneWidget);

    await tester.tap(find.text('Family'));
    await tester.pumpAndSettle();

    expect(find.text('Family activity'), findsOneWidget);
  });
}

class _NotificationsTestApp extends StatelessWidget {
  const _NotificationsTestApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: FeloTheme.dark(),
      home: const NotificationsScreen(),
    );
  }
}
