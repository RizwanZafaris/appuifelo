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
import 'package:felo/features/auth/data/mfa_repository.dart';
import 'package:felo/features/accounts/presentation/accounts_screen.dart';
import 'package:felo/features/auth/presentation/auth_recovery_screens.dart';
import 'package:felo/features/auth/presentation/auth_screen.dart';
import 'package:felo/features/bills/presentation/bills_screen.dart';
import 'package:felo/features/budgets/presentation/budgets_screen.dart';
import 'package:felo/features/coach/presentation/coach_screen.dart';
import 'package:felo/features/design_coverage/presentation/design_coverage_screen.dart';
import 'package:felo/features/do_hub/presentation/do_hub_screen.dart';
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
import 'package:felo/features/referrals/data/referrals_repository.dart';
import 'package:felo/features/referrals/domain/referral_models.dart';
import 'package:felo/features/referrals/presentation/felo_plus_screen.dart';
import 'package:felo/features/referrals/presentation/referral_redeem_screen.dart';
import 'package:felo/features/referrals/presentation/referrals_screen.dart';
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
    overrides: [
      referralsSnapshotProvider.overrideWith((ref) async => _referralsFixture),
      feloPlusProfileProvider.overrideWith(
        (ref) async => const FeloPlusProfile(subscriptionTier: 'plus'),
      ),
      mfaRepositoryProvider.overrideWithValue(_FakeMfaRepository()),
    ],
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

const _referralsFixture = ReferralsSnapshot(
  code: ReferralCode(code: 'RIZWAN5', shareUrl: 'https://felo.app/r/RIZWAN5'),
  stats: ReferralStats(
    invitedCount: 3,
    completedCount: 1,
    pendingRewardMinor: 500,
    earnedRewardMinor: 500,
    currency: 'CAD',
  ),
  invites: [
    ReferralInvite(
      id: 'referral_1',
      displayName: 'Amina',
      status: 'completed',
      rewardMinor: 500,
      currency: 'CAD',
    ),
  ],
);

void main() {
  final screens = <String, Widget>{
    'splash': const SplashScreen(),
    'onboarding': const OnboardingScreen(),
    'auth': const AuthScreen(),
    'home': const HomeScreen(),
    'do_hub': const DoHubScreen(),
    'design_coverage': const DesignCoverageScreen(),
    'design_screen': const DesignScreenAvailabilityScreen(
      screenId: 'home_dashboard_1',
    ),
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
    'referrals': const ReferralsScreen(),
    'referral_redeem': const ReferralRedeemScreen(),
    'felo_plus': const FeloPlusScreen(),
    'remittance': const RemittanceStubScreen(),
    'help': const HelpScreen(),
    'kyc': const KycScreen(),
    // Phase-2 polish
    'forgot_password': const ForgotPasswordScreen(),
    'email_verify': const EmailVerificationScreen(),
    'mfa_setup': const MfaSetupScreen(),
    'mfa_recovery_codes': const MfaRecoveryCodesScreen(
      recoveryCodes: ['AAAA-BBBB', 'CCCC-DDDD'],
    ),
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
          theme: FeloTheme.light(),
          home: const HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
  });
}

class _FakeMfaRepository implements MfaRepository {
  static const _qrPngDataUrl =
      'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+/p9sAAAAASUVORK5CYII=';

  @override
  Future<void> disable() async {}

  @override
  Future<MfaEnrollment> enroll() async {
    return const MfaEnrollment(
      secret: 'JBSWY3DPEHPK3PXP',
      otpauth: 'otpauth://totp/Felo:test@example.com',
      qrPngDataUrl: _qrPngDataUrl,
    );
  }

  @override
  Future<MfaStatus> status() async {
    return const MfaStatus(enabled: true, recoveryCodesRemaining: 8);
  }

  @override
  Future<List<String>> verifyEnrollment(String code) async {
    return const ['AAAA-BBBB', 'CCCC-DDDD'];
  }
}
