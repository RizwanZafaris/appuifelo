import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/accounts/presentation/account_connect_screen.dart';
import 'package:felo/features/accounts/presentation/accounts_screen.dart';
import 'package:felo/features/auth/presentation/auth_screen.dart';
import 'package:felo/features/bills/presentation/bills_screen.dart';
import 'package:felo/features/budgets/presentation/budget_detail_screen.dart';
import 'package:felo/features/budgets/presentation/budget_form_screen.dart';
import 'package:felo/features/budgets/presentation/budgets_screen.dart';
import 'package:felo/features/coach/presentation/coach_screen.dart';
import 'package:felo/features/family/presentation/family_screen.dart';
import 'package:felo/features/goals/presentation/goal_detail_screen.dart';
import 'package:felo/features/goals/presentation/goals_screen.dart';
import 'package:felo/features/home_dashboard/presentation/home_screen.dart';
import 'package:felo/features/notifications/presentation/notifications_screen.dart';
import 'package:felo/features/onboarding/presentation/onboarding_screen.dart';
import 'package:felo/features/onboarding/presentation/splash_screen.dart';
import 'package:felo/features/profile/presentation/profile_screen.dart';
import 'package:felo/features/receipt_capture/presentation/receipt_capture_screen.dart';
import 'package:felo/features/remittance_stub/presentation/remittance_stub_screen.dart';
import 'package:felo/features/send_money/presentation/send_money_screens.dart';
import 'package:felo/features/sms_parser/presentation/sms_parser_screen.dart';
import 'package:felo/features/transactions/presentation/transaction_detail_screen.dart';
import 'package:felo/features/transactions/presentation/transactions_screen.dart';

part 'app_router.g.dart';

final GoRouter appRouter = GoRouter(initialLocation: '/', routes: $appRoutes);

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

@TypedGoRoute<NotificationsRoute>(path: '/notifications')
class NotificationsRoute extends GoRouteData {
  const NotificationsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NotificationsScreen();
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

@TypedGoRoute<RemittanceRoute>(path: '/remittance')
class RemittanceRoute extends GoRouteData {
  const RemittanceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RemittanceStubScreen();
  }
}
