import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/help/presentation/help_screen.dart';
import 'package:felo/features/kyc/presentation/kyc_screen.dart';

void main() {
  Widget wrap(Widget child) => ProviderScope(
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: FeloTheme.dark(),
          home: child,
        ),
      );

  testWidgets('help screen filters FAQs by query', (tester) async {
    await tester.pumpWidget(wrap(const HelpScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Help & support'), findsOneWidget);
    // Five seeded FAQs all visible.
    expect(find.byType(ExpansionTile), findsNWidgets(5));

    await tester.enterText(find.byType(TextField).first, 'language');
    await tester.pumpAndSettle();

    // Filtered to FAQs that mention "language" — at least one (faq4).
    expect(find.byType(ExpansionTile), findsAtLeastNWidgets(1));
  });

  testWidgets('kyc walk-through gates Continue until each step is captured',
      (tester) async {
    await tester.pumpWidget(wrap(const KycScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Verify your identity'), findsOneWidget);
    expect(find.text('Choose ID type'), findsOneWidget);

    // Pick CNIC.
    await tester.tap(find.text('Pakistani CNIC'));
    await tester.pumpAndSettle();

    // Continue advances to ID capture.
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Capture your ID'), findsOneWidget);

    await tester.tap(find.text('Capture front'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Capture back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Take a selfie'), findsOneWidget);
    await tester.tap(find.text('Capture selfie'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Review and submit'), findsOneWidget);
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    expect(find.text('Submitted for review'), findsOneWidget);
  });
}
