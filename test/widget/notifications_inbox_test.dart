import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/budgets/data/budgets_repository.dart';
import 'package:felo/features/goals/data/goals_repository.dart';
import 'package:felo/features/notifications/presentation/notifications_screen.dart';
import 'package:felo/features/transactions/data/transactions_repository.dart';

void main() {
  testWidgets('notifications can be filtered and marked read', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Force the inbox down the fake-synthesis path. Without this,
          // the inbox would call /v1/notifications which fails in tests.
          useFakeNotificationsSourceProvider.overrideWith((_) => true),
          // Wave-1/2: synthesis reads budgets/goals via async providers.
          // Override with fakes so tests don't hit the network.
          budgetsRepositoryProvider.overrideWithValue(FakeBudgetsRepository()),
          goalsRepositoryProvider.overrideWithValue(FakeGoalsRepository()),
          transactionsRepositoryProvider.overrideWithValue(
            FakeTransactionsRepository(),
          ),
        ],
        child: const _NotificationsTestApp(),
      ),
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
