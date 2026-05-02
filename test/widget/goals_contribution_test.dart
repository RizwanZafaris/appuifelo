import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/network/dio_provider.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/goals/data/goals_repository.dart';
import 'package:felo/features/goals/presentation/goal_detail_screen.dart';

void main() {
  testWidgets('goal contribution posts amount and celebrates milestone', (
    tester,
  ) async {
    RequestOptions? contributionRequest;
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          contributionRequest = options;
          handler.resolve(
            Response<void>(requestOptions: options, statusCode: 204),
          );
        },
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dioProvider.overrideWithValue(dio),
          // Wave-1: GoalDetailScreen now reads goalsProvider (async).
          // Override the repository so the test runs without a backend.
          goalsRepositoryProvider.overrideWithValue(FakeGoalsRepository()),
        ],
        child: const _GoalsContributionTestApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -360));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Contribute'));
    await tester.pumpAndSettle();

    expect(find.text('Add to goal'), findsOneWidget);
    expect(find.text('Before'), findsOneWidget);
    expect(find.text('After'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '1000');
    await tester.pump();
    await tester.tap(find.byIcon(Icons.savings_rounded));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(contributionRequest?.path, '/goals/goal_trip/contributions');
    expect(contributionRequest?.data, {
      'amountMinor': 100000,
      'currency': 'CAD',
    });
    expect(find.text('Milestone reached'), findsOneWidget);
    expect(find.text('Trip to Pakistan reached 75%.'), findsOneWidget);
  });
}

class _GoalsContributionTestApp extends StatelessWidget {
  const _GoalsContributionTestApp();

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
      theme: FeloTheme.light(),
      home: const GoalDetailScreen(goalId: 'goal_trip'),
    );
  }
}
