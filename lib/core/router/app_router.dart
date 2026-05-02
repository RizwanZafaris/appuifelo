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
import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/feature_flags/stub_gate.dart';
import 'package:felo/features/onboarding/presentation/onboarding_screen.dart';
import 'package:felo/features/onboarding/presentation/splash_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase1_identity/otp_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase1_identity/signup_method_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase1_identity/welcome_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase2_context/confirm_region_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase2_context/name_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase2_context/region_screen_stub.dart';
import 'package:felo/features/onboarding_v2/presentation/phase3_permissions/permissions_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase4_financial/accounts_screen.dart'
    as v2_accounts;
import 'package:felo/features/onboarding_v2/presentation/phase4_financial/earning_type_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase4_financial/invest_gate_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase4_financial/investment_types_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase5_intent/budget_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase5_intent/goal_detail_screen.dart'
    as v2_goal_detail;
import 'package:felo/features/onboarding_v2/presentation/phase5_intent/goals_screen.dart'
    as v2_goals;
import 'package:felo/features/onboarding_v2/presentation/phase6_remittance/corridor_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase6_remittance/family_remittance_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase7_personalize/personalize_screen.dart';
import 'package:felo/features/onboarding_v2/presentation/phase8_dashboard/dashboard_handoff_screen.dart';
import 'package:felo/features/profile/presentation/profile_screen.dart';
import 'package:felo/features/profile/presentation/settings_screens.dart';
import 'package:felo/features/receipt_capture/presentation/receipt_capture_screen.dart';
import 'package:felo/features/referrals/presentation/felo_plus_screen.dart';
import 'package:felo/features/referrals/presentation/referral_redeem_screen.dart';
import 'package:felo/features/referrals/presentation/referrals_screen.dart';
// remittance_stub/ and send_money/ deleted in launch-readiness pass.
// Live remittance routes through /remittance (gated by FeloEnv.enableLiveRemittance);
// the manual notebook is /remittance-notebook.
import 'package:felo/features/sms_parser/presentation/sms_parser_screen.dart';
import 'package:felo/features/splits/presentation/splits_screens.dart';
import 'package:felo/features/system/presentation/system_screens.dart';
import 'package:felo/features/transactions/presentation/money_extension_screens.dart';
import 'package:felo/features/reports/presentation/weekly_report_screen.dart';
import 'package:felo/features/reports/presentation/monthly_report_screen.dart';
import 'package:felo/features/cash_envelopes/presentation/cash_envelopes_screen.dart';
import 'package:felo/features/remittance_notebook/presentation/remittance_notebook_screen.dart';
import 'package:felo/features/monthly_close/presentation/monthly_close_screen.dart';
import 'package:felo/features/subscriptions/presentation/subscription_screen.dart';
import 'package:felo/features/export_control/presentation/export_control_screen.dart';
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
  Widget build(BuildContext context, GoRouterState state) {
    // Feature flag (D-002): when v2 is enabled, redirect /onboarding
    // to /onboarding-v2 so legacy entry points jump to the new flow.
    if (FeloEnv.useOnboardingV2) {
      return const OnboardingV2WelcomeScreen();
    }
    return const OnboardingScreen();
  }
}

@TypedGoRoute<OnboardingV2WelcomeRoute>(path: '/onboarding-v2')
class OnboardingV2WelcomeRoute extends GoRouteData {
  const OnboardingV2WelcomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingV2WelcomeScreen();
}

@TypedGoRoute<OnboardingV2SignupMethodRoute>(
  path: '/onboarding-v2/signup-method',
)
class OnboardingV2SignupMethodRoute extends GoRouteData {
  const OnboardingV2SignupMethodRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingV2SignupMethodScreen();
}

@TypedGoRoute<OnboardingV2OtpRoute>(path: '/onboarding-v2/otp')
class OnboardingV2OtpRoute extends GoRouteData {
  const OnboardingV2OtpRoute({this.method = 'mobile'});

  final String method;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final method = state.extra is String
        ? state.extra! as String
        : (state.uri.queryParameters['method'] ?? 'mobile');
    return OnboardingV2OtpScreen(method: method);
  }
}

// Phase 2.1 — confirm region (replaces legacy stub at /region)
@TypedGoRoute<OnboardingV2RegionRoute>(path: '/onboarding-v2/region')
class OnboardingV2RegionRoute extends GoRouteData {
  const OnboardingV2RegionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ConfirmRegionScreen();
}

// Legacy stub — kept reachable at /region-stub for QA / fallback only.
@TypedGoRoute<OnboardingV2RegionStubRoute>(path: '/onboarding-v2/region-stub')
class OnboardingV2RegionStubRoute extends GoRouteData {
  const OnboardingV2RegionStubRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingV2RegionScreenStub();
}

// Phase 2.2 — name
@TypedGoRoute<OnboardingV2NameRoute>(path: '/onboarding-v2/name')
class OnboardingV2NameRoute extends GoRouteData {
  const OnboardingV2NameRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NameScreen();
}

// Phase 3 — permissions
@TypedGoRoute<OnboardingV2PermissionsRoute>(path: '/onboarding-v2/permissions')
class OnboardingV2PermissionsRoute extends GoRouteData {
  const OnboardingV2PermissionsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PermissionsScreen();
}

// Phase 4.1 — earning type
@TypedGoRoute<OnboardingV2EarningTypeRoute>(
  path: '/onboarding-v2/earning-type',
)
class OnboardingV2EarningTypeRoute extends GoRouteData {
  const OnboardingV2EarningTypeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EarningTypeScreen();
}

// Phase 4.2 — accounts (v2)
@TypedGoRoute<OnboardingV2AccountsRoute>(path: '/onboarding-v2/accounts')
class OnboardingV2AccountsRoute extends GoRouteData {
  const OnboardingV2AccountsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const v2_accounts.AccountsScreen();
}

// Phase 4.3 — invest gate
@TypedGoRoute<OnboardingV2InvestGateRoute>(path: '/onboarding-v2/invest-gate')
class OnboardingV2InvestGateRoute extends GoRouteData {
  const OnboardingV2InvestGateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InvestGateScreen();
}

// Phase 4.4 — investment types
@TypedGoRoute<OnboardingV2InvestTypesRoute>(
  path: '/onboarding-v2/invest-types',
)
class OnboardingV2InvestTypesRoute extends GoRouteData {
  const OnboardingV2InvestTypesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InvestmentTypesScreen();
}

// Phase 5.1 — budget
@TypedGoRoute<OnboardingV2BudgetRoute>(path: '/onboarding-v2/budget')
class OnboardingV2BudgetRoute extends GoRouteData {
  const OnboardingV2BudgetRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BudgetScreen();
}

// Phase 5.2 — goals (v2)
@TypedGoRoute<OnboardingV2GoalsRoute>(path: '/onboarding-v2/goals')
class OnboardingV2GoalsRoute extends GoRouteData {
  const OnboardingV2GoalsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const v2_goals.GoalsScreen();
}

// Phase 5.3 — goal detail (slot 1 / 2)
@TypedGoRoute<OnboardingV2GoalDetailRoute>(
  path: '/onboarding-v2/goal-detail/:slot',
)
class OnboardingV2GoalDetailRoute extends GoRouteData {
  const OnboardingV2GoalDetailRoute(this.slot);

  final String slot;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      v2_goal_detail.GoalDetailScreen(slot: int.tryParse(slot) ?? 1);
}

// Phase 6.1 — family & remittance
@TypedGoRoute<OnboardingV2FamilyRemittanceRoute>(
  path: '/onboarding-v2/family-remittance',
)
class OnboardingV2FamilyRemittanceRoute extends GoRouteData {
  const OnboardingV2FamilyRemittanceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FamilyRemittanceScreen();
}

// Phase 6.2 — corridor
@TypedGoRoute<OnboardingV2CorridorRoute>(path: '/onboarding-v2/corridor')
class OnboardingV2CorridorRoute extends GoRouteData {
  const OnboardingV2CorridorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CorridorScreen();
}

// Phase 7 — personalize (loading / orchestrator)
@TypedGoRoute<OnboardingV2PersonalizeRoute>(
  path: '/onboarding-v2/personalize',
)
class OnboardingV2PersonalizeRoute extends GoRouteData {
  const OnboardingV2PersonalizeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PersonalizeScreen();
}

// Phase 8 — dashboard handoff
@TypedGoRoute<OnboardingV2DashboardHandoffRoute>(
  path: '/onboarding-v2/dashboard-handoff',
)
class OnboardingV2DashboardHandoffRoute extends GoRouteData {
  const OnboardingV2DashboardHandoffRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DashboardHandoffScreen();
}

// Aliases — onboarding_v2 screens prefixed to disambiguate from legacy
// `OnboardingScreen` import. Kept as type aliases for cleanliness.
typedef OnboardingV2WelcomeScreen = WelcomeScreen;
typedef OnboardingV2SignupMethodScreen = SignupMethodScreen;
typedef OnboardingV2OtpScreen = OtpScreen;
typedef OnboardingV2RegionScreenStub = RegionScreenStub;

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

/// `/send/*` removed in launch-readiness. Backend has 7 live remittance
/// providers wired but no shipping mobile UI; users hit the manual
/// notebook via `/remittance-notebook`. Restoring `/send` requires the
/// new flow to land behind FeloEnv.enableLiveRemittance.

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
    return StubGate(
      enabled: FeloEnv.enableInvestments,
      featureName: 'Investments',
      child: const InvestmentsScreen(),
    );
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
  Widget build(BuildContext context, GoRouterState state) => StubGate(
        enabled: FeloEnv.enableSmsParser,
        featureName: 'SMS parser',
        child: const SmsParserScreen(),
      );
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

/// Live remittance corridor.
///
/// Default OFF in release — backend has 7 provider adapters wired but the
/// UI is the deprecated stub. When enabled at build time, redirects to
/// the manual remittance notebook so users have one consistent surface
/// until the live UI lands. The old RemittanceStubScreen is removed.
@TypedGoRoute<RemittanceRoute>(path: '/remittance')
class RemittanceRoute extends GoRouteData {
  const RemittanceRoute();

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      FeloEnv.enableLiveRemittance ? null : const RemittanceNotebookRoute().location;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return StubGate(
      enabled: FeloEnv.enableLiveRemittance,
      featureName: 'Live remittance',
      // Until the live UI lands, we route here only when the flag is on
      // (development); otherwise the redirect above lands the user on
      // the manual notebook.
      child: const RemittanceNotebookScreen(),
    );
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
  Widget build(BuildContext context, GoRouterState state) => StubGate(
        enabled: FeloEnv.enableKyc,
        featureName: 'Identity verification',
        child: const KycScreen(),
      );
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

// ─── Feature Coverage Routes ────────────────────────────────────────────

@TypedGoRoute<WeeklyReportRoute>(path: '/reports/weekly')
class WeeklyReportRoute extends GoRouteData {
  const WeeklyReportRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const WeeklyReportScreen();
}

@TypedGoRoute<MonthlyReportRoute>(path: '/reports/monthly')
class MonthlyReportRoute extends GoRouteData {
  const MonthlyReportRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MonthlyReportScreen();
}

@TypedGoRoute<CashEnvelopesRoute>(path: '/cash-envelopes')
class CashEnvelopesRoute extends GoRouteData {
  const CashEnvelopesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CashEnvelopesScreen();
}

@TypedGoRoute<RemittanceNotebookRoute>(path: '/remittance-notebook')
class RemittanceNotebookRoute extends GoRouteData {
  const RemittanceNotebookRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RemittanceNotebookScreen();
}

@TypedGoRoute<MonthlyCloseRoute>(path: '/monthly-close')
class MonthlyCloseRoute extends GoRouteData {
  const MonthlyCloseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MonthlyCloseScreen();
}

@TypedGoRoute<SubscriptionRoute>(path: '/subscription')
class SubscriptionRoute extends GoRouteData {
  const SubscriptionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SubscriptionScreen();
}

@TypedGoRoute<ExportControlRoute>(path: '/export-control')
class ExportControlRoute extends GoRouteData {
  const ExportControlRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ExportControlScreen();
}
