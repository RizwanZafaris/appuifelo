/// QA smoke test — boots every primary route and asserts the screen renders
/// without throwing. Acts as a fast gate against regressions like missing
/// l10n keys, missing providers, or null-pointer in build().
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/accounts/presentation/accounts_screen.dart';
import 'package:felo/features/auth/presentation/auth_recovery_screens.dart';
import 'package:felo/features/auth/presentation/auth_screen.dart';
import 'package:felo/features/bills/presentation/bills_screen.dart';
import 'package:felo/features/budgets/presentation/budgets_screen.dart';
import 'package:felo/features/coach/presentation/coach_screen.dart';
import 'package:felo/features/family/presentation/family_screen.dart';
import 'package:felo/features/goals/presentation/goals_screen.dart';
import 'package:felo/features/help/presentation/help_screen.dart';
import 'package:felo/features/home_dashboard/presentation/home_screen.dart';
import 'package:felo/features/kyc/presentation/kyc_screen.dart';
import 'package:felo/features/notifications/presentation/notifications_screen.dart';
import 'package:felo/features/onboarding/presentation/onboarding_screen.dart';
import 'package:felo/features/onboarding/presentation/splash_screen.dart';
import 'package:felo/features/profile/presentation/profile_screen.dart';
import 'package:felo/features/profile/presentation/settings_screens.dart';
import 'package:felo/features/remittance_stub/presentation/remittance_stub_screen.dart';
import 'package:felo/features/send_money/presentation/send_money_screens.dart';
import 'package:felo/features/sms_parser/presentation/sms_parser_screen.dart';
import 'package:felo/features/system/presentation/system_screens.dart';
import 'package:felo/features/transactions/presentation/money_extension_screens.dart';
import 'package:felo/features/transactions/presentation/transactions_screen.dart';

Widget wrap(Widget child) {
  final router = GoRouter(
    routes: [GoRoute(path: '/', builder: (_, _) => child)],
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
      theme: FeloTheme.dark(),
      routerConfig: router,
    ),
  );
}

void main() {
  final screens = <String, Widget>{
    'splash': const SplashScreen(),
    'onboarding': const OnboardingScreen(),
    'auth': const AuthScreen(),
    'home': const HomeScreen(),
    'notifications': const NotificationsScreen(),
    'accounts': const AccountsScreen(),
    'bills': const BillsScreen(),
    'send_recipient': const SendRecipientScreen(),
    'send_amount': const SendAmountScreen(),
    'send_review': const SendReviewScreen(),
    'send_success': const SendSuccessScreen(),
    'budgets': const BudgetsScreen(),
    'goals': const GoalsScreen(),
    'transactions': const TransactionsScreen(),
    'sms_parser': const SmsParserScreen(),
    'coach': const CoachScreen(),
    'family': const FamilyScreen(),
    'profile': const ProfileScreen(),
    'remittance': const RemittanceStubScreen(),
    'help': const HelpScreen(),
    'kyc': const KycScreen(),
    // Phase-2 polish
    'forgot_password': const ForgotPasswordScreen(),
    'email_verify': const EmailVerificationScreen(),
    'mfa_setup': const MfaSetupScreen(),
    'biometric_lock': const BiometricLockScreen(),
    'language_picker': const LanguagePickerScreen(),
    'theme_picker': const ThemePickerScreen(),
    'notif_prefs': const NotificationPreferencesScreen(),
    'data_export': const DataExportScreen(),
    'delete_account': const DeleteAccountScreen(),
    'about': const AboutScreen(),
    'categories': const CategoriesScreen(),
    'recurring': const RecurringScreen(),
    'insights': const InsightsScreen(),
    'search': const SearchScreen(),
    'network_error': const NetworkErrorScreen(),
    'app_lock': const AppLockScreen(),
    'family_invite': const FamilyInviteAcceptScreen(token: 'test-token'),
  };

  for (final entry in screens.entries) {
    testWidgets('${entry.key} screen renders without throwing', (tester) async {
      await tester.pumpWidget(wrap(entry.value));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // No exception means hot-path build/init succeeded.
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('rtl directionality renders home without throwing', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          locale: const Locale('ur'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: FeloTheme.dark(),
          home: const HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
  });
}
