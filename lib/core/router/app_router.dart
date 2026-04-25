import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/accounts/presentation/account_connect_screen.dart';
import 'package:felo/features/accounts/presentation/accounts_screen.dart';
import 'package:felo/features/auth/presentation/auth_recovery_screens.dart';
import 'package:felo/features/auth/presentation/auth_screen.dart';
import 'package:felo/features/bills/presentation/bills_screen.dart';
import 'package:felo/features/budgets/presentation/budget_detail_screen.dart';
import 'package:felo/features/budgets/presentation/budget_form_screen.dart';
import 'package:felo/features/budgets/presentation/budgets_screen.dart';
import 'package:felo/features/coach/presentation/coach_screen.dart';
import 'package:felo/features/design_coverage/presentation/design_coverage_screen.dart';
import 'package:felo/features/do_hub/presentation/do_hub_screen.dart';
import 'package:felo/features/family/presentation/family_screen.dart';
import 'package:felo/features/goals/presentation/goal_detail_screen.dart';
import 'package:felo/features/goals/presentation/goals_screen.dart';
import 'package:felo/features/help/presentation/help_screen.dart';
import 'package:felo/features/home_dashboard/presentation/home_screen.dart';
import 'package:felo/features/investments/presentation/investments_screens.dart';
import 'package:felo/features/kyc/presentation/kyc_screen.dart';
import 'package:felo/features/notifications/presentation/notifications_screen.dart';
import 'package:felo/features/notifications/presentation/notifications_test_screen.dart';
import 'package:felo/features/onboarding/presentation/onboarding_screen.dart';
import 'package:felo/features/onboarding/presentation/splash_screen.dart';
import 'package:felo/features/profile/presentation/profile_screen.dart';
import 'package:felo/features/profile/presentation/settings_screens.dart';
import 'package:felo/features/receipt_capture/presentation/receipt_capture_screen.dart';
import 'package:felo/features/referrals/presentation/felo_plus_screen.dart';
import 'package:felo/features/referrals/presentation/referral_redeem_screen.dart';
import 'package:felo/features/referrals/presentation/referrals_screen.dart';
import 'package:felo/features/remittance_stub/presentation/remittance_stub_screen.dart';
import 'package:felo/features/send_money/presentation/send_money_screens.dart';
import 'package:felo/features/sms_parser/presentation/sms_parser_screen.dart';
import 'package:felo/features/splits/presentation/splits_screens.dart';
import 'package:felo/features/system/presentation/system_screens.dart';
import 'package:felo/features/transactions/presentation/money_extension_screens.dart';
import 'package:felo/features/transactions/presentation/transaction_detail_screen.dart';
import 'package:felo/features/transactions/presentation/transactions_screen.dart';

part 'app_router.g.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ...$appRoutes,
    GoRoute(
      path: '/design-screens',
      builder: (context, state) => const DesignCoverageScreen(),
    ),
    GoRoute(
      path: '/design-screens/:screenId',
      builder: (context, state) => DesignScreenAvailabilityScreen(
        screenId: state.pathParameters['screenId']!,
      ),
    ),
  ],
);

@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreen();
}

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingScreen();
}

@TypedGoRoute<AuthRoute>(path: '/auth')
class AuthRoute extends GoRouteData {
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AuthScreen();
}

@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

@TypedGoRoute<DoHubRoute>(path: '/do')
class DoHubRoute extends GoRouteData {
  const DoHubRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DoHubScreen();
}

@TypedGoRoute<NotificationsRoute>(
  path: '/notifications',
  routes: [TypedGoRoute<NotificationsTestRoute>(path: 'test')],
)
class NotificationsRoute extends GoRouteData {
  const NotificationsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NotificationsScreen();
  }
}

class NotificationsTestRoute extends GoRouteData {
  const NotificationsTestRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NotificationsTestScreen();
  }
}

@TypedGoRoute<AccountsRoute>(
  path: '/accounts',
  routes: [TypedGoRoute<AccountConnectRoute>(path: 'connect')],
)
class AccountsRoute extends GoRouteData {
  const AccountsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountsScreen();
  }
}

class AccountConnectRoute extends GoRouteData {
  const AccountConnectRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountConnectScreen();
  }
}

@TypedGoRoute<BillsRoute>(path: '/bills')
class BillsRoute extends GoRouteData {
  const BillsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BillsScreen();
  }
}

@TypedGoRoute<SplitsRoute>(
  path: '/splits',
  routes: [
    TypedGoRoute<NewSplitRoute>(path: 'new'),
    TypedGoRoute<SplitDetailRoute>(path: ':splitId'),
  ],
)
class SplitsRoute extends GoRouteData {
  const SplitsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplitsScreen();
  }
}

class NewSplitRoute extends GoRouteData {
  const NewSplitRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NewSplitScreen();
  }
}

class SplitDetailRoute extends GoRouteData {
  const SplitDetailRoute(this.splitId);

  final String splitId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SplitDetailScreen(splitId: splitId);
  }
}

@TypedGoRoute<SendRoute>(
  path: '/send',
  routes: [
    TypedGoRoute<SendAmountRoute>(path: 'amount'),
    TypedGoRoute<SendReviewRoute>(path: 'review'),
    TypedGoRoute<SendSuccessRoute>(path: 'success'),
  ],
)
class SendRoute extends GoRouteData {
  const SendRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SendRecipientScreen();
  }
}

class SendAmountRoute extends GoRouteData {
  const SendAmountRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SendAmountScreen();
  }
}

class SendReviewRoute extends GoRouteData {
  const SendReviewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SendReviewScreen();
  }
}

class SendSuccessRoute extends GoRouteData {
  const SendSuccessRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SendSuccessScreen();
  }
}

@TypedGoRoute<BudgetsRoute>(
  path: '/budgets',
  routes: [
    TypedGoRoute<BudgetDetailRoute>(path: ':budgetId'),
    TypedGoRoute<BudgetFormRoute>(path: 'edit'),
  ],
)
class BudgetsRoute extends GoRouteData {
  const BudgetsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BudgetsScreen();
}

class BudgetDetailRoute extends GoRouteData {
  const BudgetDetailRoute(this.budgetId);

  final String budgetId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BudgetDetailScreen(budgetId: budgetId);
  }
}

class BudgetFormRoute extends GoRouteData {
  const BudgetFormRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BudgetFormScreen();
}

@TypedGoRoute<GoalsRoute>(
  path: '/goals',
  routes: [TypedGoRoute<GoalDetailRoute>(path: ':goalId')],
)
class GoalsRoute extends GoRouteData {
  const GoalsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const GoalsScreen();
}

class GoalDetailRoute extends GoRouteData {
  const GoalDetailRoute(this.goalId);

  final String goalId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return GoalDetailScreen(goalId: goalId);
  }
}

@TypedGoRoute<InvestmentsRoute>(
  path: '/investments',
  routes: [
    TypedGoRoute<InvestmentAddRoute>(path: 'new'),
    TypedGoRoute<InvestmentDetailRoute>(path: ':investmentId'),
  ],
)
class InvestmentsRoute extends GoRouteData {
  const InvestmentsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const InvestmentsScreen();
  }
}

class InvestmentAddRoute extends GoRouteData {
  const InvestmentAddRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const InvestmentAddScreen();
  }
}

class InvestmentDetailRoute extends GoRouteData {
  const InvestmentDetailRoute(this.investmentId);

  final String investmentId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return InvestmentDetailScreen(investmentId: investmentId);
  }
}

@TypedGoRoute<TransactionsRoute>(
  path: '/transactions',
  routes: [
    TypedGoRoute<TransactionDetailRoute>(
      path: ':transactionId',
      routes: [TypedGoRoute<ReceiptCaptureRoute>(path: 'receipt')],
    ),
  ],
)
class TransactionsRoute extends GoRouteData {
  const TransactionsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TransactionsScreen();
  }
}

class TransactionDetailRoute extends GoRouteData {
  const TransactionDetailRoute(this.transactionId);

  final String transactionId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TransactionDetailScreen(transactionId: transactionId);
  }
}

class ReceiptCaptureRoute extends GoRouteData {
  const ReceiptCaptureRoute(this.transactionId);

  final String transactionId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ReceiptCaptureScreen(transactionId: transactionId);
  }
}

@TypedGoRoute<SmsParserRoute>(path: '/sms-parser')
class SmsParserRoute extends GoRouteData {
  const SmsParserRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SmsParserScreen();
}

@TypedGoRoute<CoachRoute>(path: '/coach')
class CoachRoute extends GoRouteData {
  const CoachRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CoachScreen();
}

@TypedGoRoute<FamilyRoute>(path: '/family')
class FamilyRoute extends GoRouteData {
  const FamilyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FamilyScreen();
}

@TypedGoRoute<ProfileRoute>(path: '/profile')
class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

@TypedGoRoute<ReferralsRoute>(
  path: '/referrals',
  routes: [TypedGoRoute<ReferralRedeemRoute>(path: 'redeem')],
)
class ReferralsRoute extends GoRouteData {
  const ReferralsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ReferralsScreen();
}

class ReferralRedeemRoute extends GoRouteData {
  const ReferralRedeemRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ReferralRedeemScreen();
}

@TypedGoRoute<FeloPlusRoute>(path: '/profile/felo-plus')
class FeloPlusRoute extends GoRouteData {
  const FeloPlusRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FeloPlusScreen();
}

@TypedGoRoute<RemittanceRoute>(path: '/remittance')
class RemittanceRoute extends GoRouteData {
  const RemittanceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RemittanceStubScreen();
  }
}

@TypedGoRoute<HelpRoute>(path: '/help')
class HelpRoute extends GoRouteData {
  const HelpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HelpScreen();
}

@TypedGoRoute<KycRoute>(path: '/kyc')
class KycRoute extends GoRouteData {
  const KycRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const KycScreen();
}

// ─── Phase-2 polish routes ──────────────────────────────────────────────

@TypedGoRoute<ForgotPasswordRoute>(path: '/auth/forgot-password')
class ForgotPasswordRoute extends GoRouteData {
  const ForgotPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ForgotPasswordScreen();
}

@TypedGoRoute<EmailVerifyRoute>(path: '/auth/verify-email')
class EmailVerifyRoute extends GoRouteData {
  const EmailVerifyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EmailVerificationScreen();
}

@TypedGoRoute<MfaSetupRoute>(path: '/auth/mfa')
class MfaSetupRoute extends GoRouteData {
  const MfaSetupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MfaSetupScreen();
}

@TypedGoRoute<MfaRecoveryCodesRoute>(path: '/auth/mfa/recovery-codes')
class MfaRecoveryCodesRoute extends GoRouteData {
  const MfaRecoveryCodesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final codes = state.extra is List<String>
        ? state.extra! as List<String>
        : const <String>[];
    return MfaRecoveryCodesScreen(recoveryCodes: codes);
  }
}

@TypedGoRoute<BiometricRoute>(path: '/auth/biometric')
class BiometricRoute extends GoRouteData {
  const BiometricRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BiometricLockScreen();
}

@TypedGoRoute<LanguageRoute>(path: '/settings/language')
class LanguageRoute extends GoRouteData {
  const LanguageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LanguagePickerScreen();
}

@TypedGoRoute<ThemeRoute>(path: '/settings/theme')
class ThemeRoute extends GoRouteData {
  const ThemeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ThemePickerScreen();
}

@TypedGoRoute<NotifPrefsRoute>(path: '/settings/notifications')
class NotifPrefsRoute extends GoRouteData {
  const NotifPrefsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationPreferencesScreen();
}

@TypedGoRoute<DataExportRoute>(path: '/settings/export')
class DataExportRoute extends GoRouteData {
  const DataExportRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DataExportScreen();
}

@TypedGoRoute<DeleteAccountRoute>(path: '/settings/delete')
class DeleteAccountRoute extends GoRouteData {
  const DeleteAccountRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DeleteAccountScreen();
}

@TypedGoRoute<AboutRoute>(path: '/settings/about')
class AboutRoute extends GoRouteData {
  const AboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutScreen();
}

@TypedGoRoute<CategoriesRoute>(path: '/categories')
class CategoriesRoute extends GoRouteData {
  const CategoriesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CategoriesScreen();
}

@TypedGoRoute<RecurringRoute>(path: '/recurring')
class RecurringRoute extends GoRouteData {
  const RecurringRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RecurringScreen();
}

@TypedGoRoute<InsightsRoute>(path: '/insights')
class InsightsRoute extends GoRouteData {
  const InsightsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InsightsScreen();
}

@TypedGoRoute<SearchRoute>(path: '/search')
class SearchRoute extends GoRouteData {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SearchScreen();
}

@TypedGoRoute<NetworkErrorRoute>(path: '/error/network')
class NetworkErrorRoute extends GoRouteData {
  const NetworkErrorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NetworkErrorScreen();
}

@TypedGoRoute<AppLockRoute>(path: '/lock')
class AppLockRoute extends GoRouteData {
  const AppLockRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AppLockScreen();
}

@TypedGoRoute<FamilyInviteRoute>(path: '/family/invite/:token')
class FamilyInviteRoute extends GoRouteData {
  const FamilyInviteRoute(this.token);

  final String token;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      FamilyInviteAcceptScreen(token: token);
}
