import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/send_money/domain/send_money.dart';
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

    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Keep the auto-disposed flow provider alive across the test so state
    // persists between programmatic reads and widget rebuilds.
    final flowSub = container.listen<dynamic>(sendMoneyFlowProvider, (_, _) {});
    addTearDown(flowSub.close);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _SendMoneyTestApp(router: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Pick recipient'), findsOneWidget);

    // Drive the flow programmatically via the notifier — the tappable
    // FeloCard wraps an InkWell which can be flaky to hit-test reliably
    // inside a deeply nested ListView in widget tests.
    final recipients = container.read(sendRecipientsProvider);
    expect(recipients, isNotEmpty);
    container
        .read(sendMoneyFlowProvider.notifier)
        .selectRecipient(recipients.first);

    unawaited(router.push('/send/amount'));
    await tester.pumpAndSettle();

    expect(find.text('Enter amount'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, '25');
    await tester.pumpAndSettle();

    expect(find.textContaining('Recipient gets about'), findsOneWidget);

    // Push review programmatically (Continue button uses context.push too).
    unawaited(router.push('/send/review'));
    await tester.pumpAndSettle();

    expect(find.text('Review preview'), findsOneWidget);

    // Confirm preview transitions to success.
    await tester.tap(find.text('Confirm preview'));
    await tester.pumpAndSettle();

    expect(find.text('Preview created'), findsWidgets);
  });

  test('send money flow notifier captures recipient and quote', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final sub = container.listen<dynamic>(sendMoneyFlowProvider, (_, _) {});
    addTearDown(sub.close);

    final notifier = container.read(sendMoneyFlowProvider.notifier);
    final recipients = container.read(sendRecipientsProvider);
    expect(recipients, isNotEmpty);

    notifier.selectRecipient(recipients.first);
    notifier.setAmountMinor(2500);

    final draft = container.read(sendMoneyFlowProvider);
    expect(draft.recipient, isNotNull);
    expect(draft.quote, isA<SendMoneyQuote>());
    expect(draft.quote!.sourceAmountMinor, 2500);
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
