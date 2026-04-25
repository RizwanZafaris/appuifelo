// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashRoute,
  $onboardingRoute,
  $authRoute,
  $homeRoute,
  $notificationsRoute,
  $accountsRoute,
  $billsRoute,
  $budgetsRoute,
  $goalsRoute,
  $transactionsRoute,
  $smsParserRoute,
  $coachRoute,
  $familyRoute,
  $profileRoute,
  $remittanceRoute,
];

RouteBase get $splashRoute =>
    GoRouteData.$route(path: '/', factory: $SplashRouteExtension._fromState);

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location('/');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingRoute => GoRouteData.$route(
  path: '/onboarding',

  factory: $OnboardingRouteExtension._fromState,
);

extension $OnboardingRouteExtension on OnboardingRoute {
  static OnboardingRoute _fromState(GoRouterState state) =>
      const OnboardingRoute();

  String get location => GoRouteData.$location('/onboarding');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authRoute =>
    GoRouteData.$route(path: '/auth', factory: $AuthRouteExtension._fromState);

extension $AuthRouteExtension on AuthRoute {
  static AuthRoute _fromState(GoRouterState state) => const AuthRoute();

  String get location => GoRouteData.$location('/auth');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRoute =>
    GoRouteData.$route(path: '/home', factory: $HomeRouteExtension._fromState);

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location('/home');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $notificationsRoute => GoRouteData.$route(
  path: '/notifications',

  factory: $NotificationsRouteExtension._fromState,
);

extension $NotificationsRouteExtension on NotificationsRoute {
  static NotificationsRoute _fromState(GoRouterState state) =>
      const NotificationsRoute();

  String get location => GoRouteData.$location('/notifications');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $accountsRoute => GoRouteData.$route(
  path: '/accounts',

  factory: $AccountsRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: 'connect',

      factory: $AccountConnectRouteExtension._fromState,
    ),
  ],
);

extension $AccountsRouteExtension on AccountsRoute {
  static AccountsRoute _fromState(GoRouterState state) => const AccountsRoute();

  String get location => GoRouteData.$location('/accounts');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountConnectRouteExtension on AccountConnectRoute {
  static AccountConnectRoute _fromState(GoRouterState state) =>
      const AccountConnectRoute();

  String get location => GoRouteData.$location('/accounts/connect');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $billsRoute => GoRouteData.$route(
  path: '/bills',

  factory: $BillsRouteExtension._fromState,
);

extension $BillsRouteExtension on BillsRoute {
  static BillsRoute _fromState(GoRouterState state) => const BillsRoute();

  String get location => GoRouteData.$location('/bills');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $budgetsRoute => GoRouteData.$route(
  path: '/budgets',

  factory: $BudgetsRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: ':budgetId',

      factory: $BudgetDetailRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'edit',

      factory: $BudgetFormRouteExtension._fromState,
    ),
  ],
);

extension $BudgetsRouteExtension on BudgetsRoute {
  static BudgetsRoute _fromState(GoRouterState state) => const BudgetsRoute();

  String get location => GoRouteData.$location('/budgets');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BudgetDetailRouteExtension on BudgetDetailRoute {
  static BudgetDetailRoute _fromState(GoRouterState state) =>
      BudgetDetailRoute(state.pathParameters['budgetId']!);

  String get location =>
      GoRouteData.$location('/budgets/${Uri.encodeComponent(budgetId)}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BudgetFormRouteExtension on BudgetFormRoute {
  static BudgetFormRoute _fromState(GoRouterState state) =>
      const BudgetFormRoute();

  String get location => GoRouteData.$location('/budgets/edit');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $goalsRoute => GoRouteData.$route(
  path: '/goals',

  factory: $GoalsRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: ':goalId',

      factory: $GoalDetailRouteExtension._fromState,
    ),
  ],
);

extension $GoalsRouteExtension on GoalsRoute {
  static GoalsRoute _fromState(GoRouterState state) => const GoalsRoute();

  String get location => GoRouteData.$location('/goals');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GoalDetailRouteExtension on GoalDetailRoute {
  static GoalDetailRoute _fromState(GoRouterState state) =>
      GoalDetailRoute(state.pathParameters['goalId']!);

  String get location =>
      GoRouteData.$location('/goals/${Uri.encodeComponent(goalId)}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $transactionsRoute => GoRouteData.$route(
  path: '/transactions',

  factory: $TransactionsRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: ':transactionId',

      factory: $TransactionDetailRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'receipt',

          factory: $ReceiptCaptureRouteExtension._fromState,
        ),
      ],
    ),
  ],
);

extension $TransactionsRouteExtension on TransactionsRoute {
  static TransactionsRoute _fromState(GoRouterState state) =>
      const TransactionsRoute();

  String get location => GoRouteData.$location('/transactions');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TransactionDetailRouteExtension on TransactionDetailRoute {
  static TransactionDetailRoute _fromState(GoRouterState state) =>
      TransactionDetailRoute(state.pathParameters['transactionId']!);

  String get location => GoRouteData.$location(
    '/transactions/${Uri.encodeComponent(transactionId)}',
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ReceiptCaptureRouteExtension on ReceiptCaptureRoute {
  static ReceiptCaptureRoute _fromState(GoRouterState state) =>
      ReceiptCaptureRoute(state.pathParameters['transactionId']!);

  String get location => GoRouteData.$location(
    '/transactions/${Uri.encodeComponent(transactionId)}/receipt',
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $smsParserRoute => GoRouteData.$route(
  path: '/sms-parser',

  factory: $SmsParserRouteExtension._fromState,
);

extension $SmsParserRouteExtension on SmsParserRoute {
  static SmsParserRoute _fromState(GoRouterState state) =>
      const SmsParserRoute();

  String get location => GoRouteData.$location('/sms-parser');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $coachRoute => GoRouteData.$route(
  path: '/coach',

  factory: $CoachRouteExtension._fromState,
);

extension $CoachRouteExtension on CoachRoute {
  static CoachRoute _fromState(GoRouterState state) => const CoachRoute();

  String get location => GoRouteData.$location('/coach');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $familyRoute => GoRouteData.$route(
  path: '/family',

  factory: $FamilyRouteExtension._fromState,
);

extension $FamilyRouteExtension on FamilyRoute {
  static FamilyRoute _fromState(GoRouterState state) => const FamilyRoute();

  String get location => GoRouteData.$location('/family');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $profileRoute => GoRouteData.$route(
  path: '/profile',

  factory: $ProfileRouteExtension._fromState,
);

extension $ProfileRouteExtension on ProfileRoute {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  String get location => GoRouteData.$location('/profile');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $remittanceRoute => GoRouteData.$route(
  path: '/remittance',

  factory: $RemittanceRouteExtension._fromState,
);

extension $RemittanceRouteExtension on RemittanceRoute {
  static RemittanceRoute _fromState(GoRouterState state) =>
      const RemittanceRoute();

  String get location => GoRouteData.$location('/remittance');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
