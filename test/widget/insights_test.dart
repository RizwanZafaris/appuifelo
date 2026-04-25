import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/transactions/domain/spending_insights.dart';
import 'package:felo/features/transactions/presentation/money_extension_screens.dart';

void main() {
  testWidgets('insights screen renders spending sections from backend data', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          spendingInsightsProvider(InsightsPeriod.month).overrideWith(
            (ref) async => const SpendingInsights(
              totalMinor: 124500,
              currency: 'CAD',
              byCategory: [
                SpendingInsightCategory(
                  category: 'Groceries',
                  totalMinor: 52000,
                ),
                SpendingInsightCategory(
                  category: 'Transport',
                  totalMinor: 26000,
                ),
              ],
              byMerchant: [
                SpendingInsightMerchant(
                  merchant: 'No Frills',
                  totalMinor: 33000,
                ),
                SpendingInsightMerchant(merchant: 'Presto', totalMinor: 12500),
              ],
              trends: [
                SpendingInsightTrend(date: '2026-04-01', totalMinor: 20000),
                SpendingInsightTrend(date: '2026-04-08', totalMinor: 35000),
                SpendingInsightTrend(date: '2026-04-15', totalMinor: 49000),
              ],
            ),
          ),
        ],
        child: const _InsightsTestApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Insights'), findsOneWidget);
    expect(find.text('Spent this month'), findsOneWidget);
    expect(find.text('By category'), findsOneWidget);
    expect(find.text('Groceries'), findsOneWidget);
    expect(find.text('Top merchants'), findsOneWidget);
    expect(find.text('No Frills'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Trend'),
      240,
      scrollable: find.byType(Scrollable),
    );

    expect(find.text('Trend'), findsOneWidget);
  });
}

class _InsightsTestApp extends StatelessWidget {
  const _InsightsTestApp();

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
      home: const InsightsScreen(),
    );
  }
}
