import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/bills/presentation/bills_screen.dart';

void main() {
  testWidgets('bills screen marks an upcoming bill paid', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: _BillsTestApp()));
    await tester.pumpAndSettle();

    expect(find.text('Bills'), findsOneWidget);
    expect(find.text('K-Electric'), findsOneWidget);

    await tester.tap(find.text('Mark paid').first);
    await tester.pumpAndSettle();

    expect(find.text('Paid'), findsWidgets);
  });
}

class _BillsTestApp extends StatelessWidget {
  const _BillsTestApp();

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
      home: const BillsScreen(),
    );
  }
}
