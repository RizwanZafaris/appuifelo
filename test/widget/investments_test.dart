import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/investments/presentation/investments_screens.dart';

Widget _wrap() {
  final router = GoRouter(
    initialLocation: '/investments',
    routes: [
      GoRoute(
        path: '/investments',
        builder: (_, _) => const InvestmentsScreen(),
        routes: [
          GoRoute(path: 'new', builder: (_, _) => const InvestmentAddScreen()),
          GoRoute(
            path: ':investmentId',
            builder: (_, state) => InvestmentDetailScreen(
              investmentId: state.pathParameters['investmentId']!,
            ),
          ),
        ],
      ),
    ],
  );

  return ProviderScope(
    child: MaterialApp.router(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: FeloTheme.light(),
      routerConfig: router,
    ),
  );
}

void main() {
  testWidgets('investment happy path adds asset and opens detail', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1100));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_wrap());
    await tester.pumpAndSettle();

    expect(find.text('Investments'), findsOneWidget);
    expect(find.text('Total market value'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Symbol'), 'GLD');
    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Gold fund');
    await tester.enterText(find.widgetWithText(TextField, 'Units'), '2');
    await tester.enterText(find.widgetWithText(TextField, 'Cost basis'), '300');
    await tester.tap(find.text('Save asset'));
    await tester.pumpAndSettle();

    expect(find.text('GLD'), findsOneWidget);
    expect(find.text('Gold fund'), findsOneWidget);
    expect(find.text('Market value'), findsOneWidget);
  });
}
