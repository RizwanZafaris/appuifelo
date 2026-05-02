import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/splits/presentation/splits_screens.dart';

void main() {
  testWidgets('creates a split and settles it from detail', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: _SplitsTestApp()));
    await tester.pumpAndSettle();

    expect(find.text('Splits'), findsOneWidget);
    expect(find.text('May rent'), findsOneWidget);

    await tester.tap(find.text('New split'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create split'));
    await tester.pumpAndSettle();

    expect(find.text('Dinner split'), findsWidgets);
    expect(find.text('0 of 2 paid'), findsOneWidget);

    await tester.drag(find.byType(ListView).last, const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Settle all'));
    await tester.pumpAndSettle();

    expect(find.text('2 of 2 paid'), findsOneWidget);
  });
}

class _SplitsTestApp extends StatelessWidget {
  const _SplitsTestApp();

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/splits',
      routes: [
        GoRoute(
          path: '/splits',
          builder: (context, state) => const SplitsScreen(),
          routes: [
            GoRoute(
              path: 'new',
              builder: (context, state) => const NewSplitScreen(),
            ),
            GoRoute(
              path: ':splitId',
              builder: (context, state) =>
                  SplitDetailScreen(splitId: state.pathParameters['splitId']!),
            ),
          ],
        ),
      ],
    );

    return MaterialApp.router(
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
    );
  }
}
