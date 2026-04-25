import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/send_money/presentation/send_money_screens.dart';

void main() {
  testWidgets('send money preview walks through all routed steps', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/send',
      routes: [
        GoRoute(
          path: '/send',
          builder: (context, state) => const SendRecipientScreen(),
          routes: [
            GoRoute(
              path: 'amount',
              builder: (context, state) => const SendAmountScreen(),
            ),
            GoRoute(
              path: 'review',
              builder: (context, state) => const SendReviewScreen(),
            ),
            GoRoute(
              path: 'success',
              builder: (context, state) => const SendSuccessScreen(),
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: _SendMoneyTestApp(router: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Pick recipient'), findsOneWidget);

    await tester.tap(find.text('Ali Reza'));
    await tester.pumpAndSettle();

    expect(find.text('Enter amount'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '25');
    await tester.pumpAndSettle();

    expect(find.textContaining('Recipient gets about'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Review preview'), findsOneWidget);

    await tester.tap(find.text('Confirm preview'));
    await tester.pumpAndSettle();

    expect(find.text('Preview created'), findsWidgets);
  });
}

class _SendMoneyTestApp extends StatelessWidget {
  const _SendMoneyTestApp({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: FeloTheme.dark(),
      routerConfig: router,
    );
  }
}
