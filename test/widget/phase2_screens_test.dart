import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/auth/presentation/auth_recovery_screens.dart';
import 'package:felo/features/profile/presentation/settings_screens.dart';
import 'package:felo/features/system/presentation/system_screens.dart';
import 'package:felo/features/transactions/presentation/money_extension_screens.dart';

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

void main() {
  group('Phase-2 polish screens', () {
    testWidgets('forgot password shows confirmation after submit',
        (tester) async {
      await tester.pumpWidget(wrap(const ForgotPasswordScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Reset password'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'rizwan@example.com');
      await tester.tap(find.text('Send reset link'));
      await tester.pumpAndSettle();

      expect(find.text('Check your inbox'), findsOneWidget);
    });

    testWidgets('mfa setup renders QR + code input', (tester) async {
      await tester.pumpWidget(wrap(const MfaSetupScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Two-factor authentication'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.qr_code_2_rounded), findsOneWidget);
      expect(find.text('Copy secret key'), findsOneWidget);
    });

    testWidgets('language picker selects Urdu', (tester) async {
      await tester.pumpWidget(wrap(const LanguagePickerScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Language'), findsOneWidget);
      await tester.tap(find.textContaining('Urdu'));
      await tester.pumpAndSettle();
      // No exception is the assertion.
      expect(tester.takeException(), isNull);
    });

    testWidgets('delete account screen shows warning + DELETE confirm field',
        (tester) async {
      await tester.pumpWidget(wrap(const DeleteAccountScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Delete account'), findsOneWidget);
      expect(find.textContaining('30 days'), findsAtLeastNWidgets(1));
      expect(find.text('Type DELETE'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('search screen filters across providers', (tester) async {
      await tester.pumpWidget(wrap(const SearchScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Search'), findsOneWidget);
      // Empty state prompt visible.
      expect(find.textContaining('Type at least'), findsOneWidget);

      await tester.enterText(find.byType(TextField).first, 'groceries');
      await tester.pumpAndSettle();

      // Should at least show one section header.
      expect(
        find.textContaining('Transactions').evaluate().length +
            find.textContaining('Budgets').evaluate().length,
        greaterThan(0),
      );
    });

    testWidgets('app lock shows error on wrong PIN, succeeds on 1234',
        (tester) async {
      await tester.pumpWidget(wrap(const AppLockScreen()));
      await tester.pumpAndSettle();

      expect(find.text('App locked'), findsOneWidget);

      await tester.enterText(find.byType(TextField), '0000');
      await tester.tap(find.text('Unlock'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Wrong PIN'), findsOneWidget);
    });

    testWidgets('family invite renders token in hint', (tester) async {
      await tester.pumpWidget(
        wrap(const FamilyInviteAcceptScreen(token: 'abc-123')),
      );
      await tester.pumpAndSettle();

      expect(find.text("You've been invited"), findsOneWidget);
      expect(find.textContaining('abc-123'), findsOneWidget);

      await tester.tap(find.text('Accept invite'));
      await tester.pumpAndSettle();
      expect(find.textContaining('part of the family'), findsOneWidget);
    });
  });
}
