import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/features/splits/data/splits_repository.dart';
import 'package:felo/features/splits/presentation/splits_screens.dart';

Widget _wrap(Widget child, {required Size size}) {
  return MediaQuery(
    data: MediaQueryData(size: size),
    child: ProviderScope(
      overrides: [
        splitsRepositoryProvider.overrideWith((ref) => FakeSplitsRepository()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    ),
  );
}

void main() {
  testWidgets('phone width (<600dp): tabbed single-column', (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(_wrap(const SplitsScreen(), size: const Size(400, 800)));
    await tester.pump();

    expect(find.byType(TabBar), findsOneWidget);
    expect(find.byType(TabBarView), findsOneWidget);
    expect(find.byType(VerticalDivider), findsNothing);
  });

  testWidgets('tablet width (≥600dp): side-by-side panes, no TabBar', (tester) async {
    tester.view.physicalSize = const Size(900, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(_wrap(const SplitsScreen(), size: const Size(900, 800)));
    await tester.pump();

    expect(find.byType(TabBar), findsNothing);
    expect(find.byType(TabBarView), findsNothing);
    expect(find.byType(VerticalDivider), findsOneWidget);
  });

  test('breakpoint constant is 600', () {
    expect(splitsTabletBreakpoint, 600);
  });
}
