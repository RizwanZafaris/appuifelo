// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashRoute,
  $onboardingRoute,
  $onboardingV2WelcomeRoute,
  $onboardingV2SignupMethodRoute,
  $onboardingV2OtpRoute,
  $onboardingV2RegionRoute,
  $onboardingV2RegionStubRoute,
  $onboardingV2NameRoute,
  $onboardingV2PermissionsRoute,
  $onboardingV2EarningTypeRoute,
  $onboardingV2AccountsRoute,
  $onboardingV2InvestGateRoute,
  $onboardingV2InvestTypesRoute,
  $onboardingV2BudgetRoute,
  $onboardingV2GoalsRoute,
  $onboardingV2GoalDetailRoute,
  $onboardingV2FamilyRemittanceRoute,
  $onboardingV2CorridorRoute,
  $onboardingV2PersonalizeRoute,
  $onboardingV2DashboardHandoffRoute,
  $authRoute,
  $homeRoute,
  $doHubRoute,
  $notificationsRoute,
  $accountsRoute,
  $billsRoute,
  $splitsRoute,
  $budgetsRoute,
  $goalsRoute,
  $investmentsRoute,
  $transactionsRoute,
  $smsParserRoute,
  $coachRoute,
  $familyRoute,
  $profileRoute,
  $referralsRoute,
  $feloPlusRoute,
  $remittanceRoute,
  $helpRoute,
  $kycRoute,
  $forgotPasswordRoute,
  $emailVerifyRoute,
  $mfaSetupRoute,
  $mfaRecoveryCodesRoute,
  $biometricRoute,
  $languageRoute,
  $themeRoute,
  $notifPrefsRoute,
  $dataExportRoute,
  $deleteAccountRoute,
  $aboutRoute,
  $categoriesRoute,
  $recurringRoute,
  $insightsRoute,
  $searchRoute,
  $networkErrorRoute,
  $appLockRoute,
  $familyInviteRoute,
  $weeklyReportRoute,
  $monthlyReportRoute,
  $cashEnvelopesRoute,
  $remittanceNotebookRoute,
  $monthlyCloseRoute,
  $subscriptionRoute,
  $exportControlRoute,
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

RouteBase get $onboardingV2WelcomeRoute => GoRouteData.$route(
  path: '/onboarding-v2',

  factory: $OnboardingV2WelcomeRouteExtension._fromState,
);

extension $OnboardingV2WelcomeRouteExtension on OnboardingV2WelcomeRoute {
  static OnboardingV2WelcomeRoute _fromState(GoRouterState state) =>
      const OnboardingV2WelcomeRoute();

  String get location => GoRouteData.$location('/onboarding-v2');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2SignupMethodRoute => GoRouteData.$route(
  path: '/onboarding-v2/signup-method',

  factory: $OnboardingV2SignupMethodRouteExtension._fromState,
);

extension $OnboardingV2SignupMethodRouteExtension
    on OnboardingV2SignupMethodRoute {
  static OnboardingV2SignupMethodRoute _fromState(GoRouterState state) =>
      const OnboardingV2SignupMethodRoute();

  String get location => GoRouteData.$location('/onboarding-v2/signup-method');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2OtpRoute => GoRouteData.$route(
  path: '/onboarding-v2/otp',

  factory: $OnboardingV2OtpRouteExtension._fromState,
);

extension $OnboardingV2OtpRouteExtension on OnboardingV2OtpRoute {
  static OnboardingV2OtpRoute _fromState(GoRouterState state) =>
      OnboardingV2OtpRoute(
        method: state.uri.queryParameters['method'] ?? 'mobile',
      );

  String get location => GoRouteData.$location(
    '/onboarding-v2/otp',
    queryParams: {if (method != 'mobile') 'method': method},
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2RegionRoute => GoRouteData.$route(
  path: '/onboarding-v2/region',

  factory: $OnboardingV2RegionRouteExtension._fromState,
);

extension $OnboardingV2RegionRouteExtension on OnboardingV2RegionRoute {
  static OnboardingV2RegionRoute _fromState(GoRouterState state) =>
      const OnboardingV2RegionRoute();

  String get location => GoRouteData.$location('/onboarding-v2/region');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2RegionStubRoute => GoRouteData.$route(
  path: '/onboarding-v2/region-stub',

  factory: $OnboardingV2RegionStubRouteExtension._fromState,
);

extension $OnboardingV2RegionStubRouteExtension on OnboardingV2RegionStubRoute {
  static OnboardingV2RegionStubRoute _fromState(GoRouterState state) =>
      const OnboardingV2RegionStubRoute();

  String get location => GoRouteData.$location('/onboarding-v2/region-stub');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2NameRoute => GoRouteData.$route(
  path: '/onboarding-v2/name',

  factory: $OnboardingV2NameRouteExtension._fromState,
);

extension $OnboardingV2NameRouteExtension on OnboardingV2NameRoute {
  static OnboardingV2NameRoute _fromState(GoRouterState state) =>
      const OnboardingV2NameRoute();

  String get location => GoRouteData.$location('/onboarding-v2/name');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2PermissionsRoute => GoRouteData.$route(
  path: '/onboarding-v2/permissions',

  factory: $OnboardingV2PermissionsRouteExtension._fromState,
);

extension $OnboardingV2PermissionsRouteExtension
    on OnboardingV2PermissionsRoute {
  static OnboardingV2PermissionsRoute _fromState(GoRouterState state) =>
      const OnboardingV2PermissionsRoute();

  String get location => GoRouteData.$location('/onboarding-v2/permissions');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2EarningTypeRoute => GoRouteData.$route(
  path: '/onboarding-v2/earning-type',

  factory: $OnboardingV2EarningTypeRouteExtension._fromState,
);

extension $OnboardingV2EarningTypeRouteExtension
    on OnboardingV2EarningTypeRoute {
  static OnboardingV2EarningTypeRoute _fromState(GoRouterState state) =>
      const OnboardingV2EarningTypeRoute();

  String get location => GoRouteData.$location('/onboarding-v2/earning-type');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2AccountsRoute => GoRouteData.$route(
  path: '/onboarding-v2/accounts',

  factory: $OnboardingV2AccountsRouteExtension._fromState,
);

extension $OnboardingV2AccountsRouteExtension on OnboardingV2AccountsRoute {
  static OnboardingV2AccountsRoute _fromState(GoRouterState state) =>
      const OnboardingV2AccountsRoute();

  String get location => GoRouteData.$location('/onboarding-v2/accounts');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2InvestGateRoute => GoRouteData.$route(
  path: '/onboarding-v2/invest-gate',

  factory: $OnboardingV2InvestGateRouteExtension._fromState,
);

extension $OnboardingV2InvestGateRouteExtension on OnboardingV2InvestGateRoute {
  static OnboardingV2InvestGateRoute _fromState(GoRouterState state) =>
      const OnboardingV2InvestGateRoute();

  String get location => GoRouteData.$location('/onboarding-v2/invest-gate');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2InvestTypesRoute => GoRouteData.$route(
  path: '/onboarding-v2/invest-types',

  factory: $OnboardingV2InvestTypesRouteExtension._fromState,
);

extension $OnboardingV2InvestTypesRouteExtension
    on OnboardingV2InvestTypesRoute {
  static OnboardingV2InvestTypesRoute _fromState(GoRouterState state) =>
      const OnboardingV2InvestTypesRoute();

  String get location => GoRouteData.$location('/onboarding-v2/invest-types');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2BudgetRoute => GoRouteData.$route(
  path: '/onboarding-v2/budget',

  factory: $OnboardingV2BudgetRouteExtension._fromState,
);

extension $OnboardingV2BudgetRouteExtension on OnboardingV2BudgetRoute {
  static OnboardingV2BudgetRoute _fromState(GoRouterState state) =>
      const OnboardingV2BudgetRoute();

  String get location => GoRouteData.$location('/onboarding-v2/budget');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2GoalsRoute => GoRouteData.$route(
  path: '/onboarding-v2/goals',

  factory: $OnboardingV2GoalsRouteExtension._fromState,
);

extension $OnboardingV2GoalsRouteExtension on OnboardingV2GoalsRoute {
  static OnboardingV2GoalsRoute _fromState(GoRouterState state) =>
      const OnboardingV2GoalsRoute();

  String get location => GoRouteData.$location('/onboarding-v2/goals');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2GoalDetailRoute => GoRouteData.$route(
  path: '/onboarding-v2/goal-detail/:slot',

  factory: $OnboardingV2GoalDetailRouteExtension._fromState,
);

extension $OnboardingV2GoalDetailRouteExtension on OnboardingV2GoalDetailRoute {
  static OnboardingV2GoalDetailRoute _fromState(GoRouterState state) =>
      OnboardingV2GoalDetailRoute(state.pathParameters['slot']!);

  String get location => GoRouteData.$location(
    '/onboarding-v2/goal-detail/${Uri.encodeComponent(slot)}',
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2FamilyRemittanceRoute => GoRouteData.$route(
  path: '/onboarding-v2/family-remittance',

  factory: $OnboardingV2FamilyRemittanceRouteExtension._fromState,
);

extension $OnboardingV2FamilyRemittanceRouteExtension
    on OnboardingV2FamilyRemittanceRoute {
  static OnboardingV2FamilyRemittanceRoute _fromState(GoRouterState state) =>
      const OnboardingV2FamilyRemittanceRoute();

  String get location =>
      GoRouteData.$location('/onboarding-v2/family-remittance');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2CorridorRoute => GoRouteData.$route(
  path: '/onboarding-v2/corridor',

  factory: $OnboardingV2CorridorRouteExtension._fromState,
);

extension $OnboardingV2CorridorRouteExtension on OnboardingV2CorridorRoute {
  static OnboardingV2CorridorRoute _fromState(GoRouterState state) =>
      const OnboardingV2CorridorRoute();

  String get location => GoRouteData.$location('/onboarding-v2/corridor');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2PersonalizeRoute => GoRouteData.$route(
  path: '/onboarding-v2/personalize',

  factory: $OnboardingV2PersonalizeRouteExtension._fromState,
);

extension $OnboardingV2PersonalizeRouteExtension
    on OnboardingV2PersonalizeRoute {
  static OnboardingV2PersonalizeRoute _fromState(GoRouterState state) =>
      const OnboardingV2PersonalizeRoute();

  String get location => GoRouteData.$location('/onboarding-v2/personalize');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingV2DashboardHandoffRoute => GoRouteData.$route(
  path: '/onboarding-v2/dashboard-handoff',

  factory: $OnboardingV2DashboardHandoffRouteExtension._fromState,
);

extension $OnboardingV2DashboardHandoffRouteExtension
    on OnboardingV2DashboardHandoffRoute {
  static OnboardingV2DashboardHandoffRoute _fromState(GoRouterState state) =>
      const OnboardingV2DashboardHandoffRoute();

  String get location =>
      GoRouteData.$location('/onboarding-v2/dashboard-handoff');

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

RouteBase get $doHubRoute =>
    GoRouteData.$route(path: '/do', factory: $DoHubRouteExtension._fromState);

extension $DoHubRouteExtension on DoHubRoute {
  static DoHubRoute _fromState(GoRouterState state) => const DoHubRoute();

  String get location => GoRouteData.$location('/do');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $notificationsRoute => GoRouteData.$route(
  path: '/notifications',

  factory: $NotificationsRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: 'test',

      factory: $NotificationsTestRouteExtension._fromState,
    ),
  ],
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

extension $NotificationsTestRouteExtension on NotificationsTestRoute {
  static NotificationsTestRoute _fromState(GoRouterState state) =>
      const NotificationsTestRoute();

  String get location => GoRouteData.$location('/notifications/test');

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

RouteBase get $splitsRoute => GoRouteData.$route(
  path: '/splits',

  factory: $SplitsRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: 'new',

      factory: $NewSplitRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: ':splitId',

      factory: $SplitDetailRouteExtension._fromState,
    ),
  ],
);

extension $SplitsRouteExtension on SplitsRoute {
  static SplitsRoute _fromState(GoRouterState state) => const SplitsRoute();

  String get location => GoRouteData.$location('/splits');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NewSplitRouteExtension on NewSplitRoute {
  static NewSplitRoute _fromState(GoRouterState state) => const NewSplitRoute();

  String get location => GoRouteData.$location('/splits/new');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SplitDetailRouteExtension on SplitDetailRoute {
  static SplitDetailRoute _fromState(GoRouterState state) =>
      SplitDetailRoute(state.pathParameters['splitId']!);

  String get location =>
      GoRouteData.$location('/splits/${Uri.encodeComponent(splitId)}');

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

RouteBase get $investmentsRoute => GoRouteData.$route(
  path: '/investments',

  factory: $InvestmentsRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: 'new',

      factory: $InvestmentAddRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: ':investmentId',

      factory: $InvestmentDetailRouteExtension._fromState,
    ),
  ],
);

extension $InvestmentsRouteExtension on InvestmentsRoute {
  static InvestmentsRoute _fromState(GoRouterState state) =>
      const InvestmentsRoute();

  String get location => GoRouteData.$location('/investments');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $InvestmentAddRouteExtension on InvestmentAddRoute {
  static InvestmentAddRoute _fromState(GoRouterState state) =>
      const InvestmentAddRoute();

  String get location => GoRouteData.$location('/investments/new');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $InvestmentDetailRouteExtension on InvestmentDetailRoute {
  static InvestmentDetailRoute _fromState(GoRouterState state) =>
      InvestmentDetailRoute(state.pathParameters['investmentId']!);

  String get location => GoRouteData.$location(
    '/investments/${Uri.encodeComponent(investmentId)}',
  );

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

RouteBase get $referralsRoute => GoRouteData.$route(
  path: '/referrals',

  factory: $ReferralsRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: 'redeem',

      factory: $ReferralRedeemRouteExtension._fromState,
    ),
  ],
);

extension $ReferralsRouteExtension on ReferralsRoute {
  static ReferralsRoute _fromState(GoRouterState state) =>
      const ReferralsRoute();

  String get location => GoRouteData.$location('/referrals');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ReferralRedeemRouteExtension on ReferralRedeemRoute {
  static ReferralRedeemRoute _fromState(GoRouterState state) =>
      const ReferralRedeemRoute();

  String get location => GoRouteData.$location('/referrals/redeem');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $feloPlusRoute => GoRouteData.$route(
  path: '/profile/felo-plus',

  factory: $FeloPlusRouteExtension._fromState,
);

extension $FeloPlusRouteExtension on FeloPlusRoute {
  static FeloPlusRoute _fromState(GoRouterState state) => const FeloPlusRoute();

  String get location => GoRouteData.$location('/profile/felo-plus');

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

RouteBase get $helpRoute =>
    GoRouteData.$route(path: '/help', factory: $HelpRouteExtension._fromState);

extension $HelpRouteExtension on HelpRoute {
  static HelpRoute _fromState(GoRouterState state) => const HelpRoute();

  String get location => GoRouteData.$location('/help');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $kycRoute =>
    GoRouteData.$route(path: '/kyc', factory: $KycRouteExtension._fromState);

extension $KycRouteExtension on KycRoute {
  static KycRoute _fromState(GoRouterState state) => const KycRoute();

  String get location => GoRouteData.$location('/kyc');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $forgotPasswordRoute => GoRouteData.$route(
  path: '/auth/forgot-password',

  factory: $ForgotPasswordRouteExtension._fromState,
);

extension $ForgotPasswordRouteExtension on ForgotPasswordRoute {
  static ForgotPasswordRoute _fromState(GoRouterState state) =>
      const ForgotPasswordRoute();

  String get location => GoRouteData.$location('/auth/forgot-password');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $emailVerifyRoute => GoRouteData.$route(
  path: '/auth/verify-email',

  factory: $EmailVerifyRouteExtension._fromState,
);

extension $EmailVerifyRouteExtension on EmailVerifyRoute {
  static EmailVerifyRoute _fromState(GoRouterState state) =>
      const EmailVerifyRoute();

  String get location => GoRouteData.$location('/auth/verify-email');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mfaSetupRoute => GoRouteData.$route(
  path: '/auth/mfa',

  factory: $MfaSetupRouteExtension._fromState,
);

extension $MfaSetupRouteExtension on MfaSetupRoute {
  static MfaSetupRoute _fromState(GoRouterState state) => const MfaSetupRoute();

  String get location => GoRouteData.$location('/auth/mfa');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mfaRecoveryCodesRoute => GoRouteData.$route(
  path: '/auth/mfa/recovery-codes',

  factory: $MfaRecoveryCodesRouteExtension._fromState,
);

extension $MfaRecoveryCodesRouteExtension on MfaRecoveryCodesRoute {
  static MfaRecoveryCodesRoute _fromState(GoRouterState state) =>
      const MfaRecoveryCodesRoute();

  String get location => GoRouteData.$location('/auth/mfa/recovery-codes');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $biometricRoute => GoRouteData.$route(
  path: '/auth/biometric',

  factory: $BiometricRouteExtension._fromState,
);

extension $BiometricRouteExtension on BiometricRoute {
  static BiometricRoute _fromState(GoRouterState state) =>
      const BiometricRoute();

  String get location => GoRouteData.$location('/auth/biometric');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $languageRoute => GoRouteData.$route(
  path: '/settings/language',

  factory: $LanguageRouteExtension._fromState,
);

extension $LanguageRouteExtension on LanguageRoute {
  static LanguageRoute _fromState(GoRouterState state) => const LanguageRoute();

  String get location => GoRouteData.$location('/settings/language');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $themeRoute => GoRouteData.$route(
  path: '/settings/theme',

  factory: $ThemeRouteExtension._fromState,
);

extension $ThemeRouteExtension on ThemeRoute {
  static ThemeRoute _fromState(GoRouterState state) => const ThemeRoute();

  String get location => GoRouteData.$location('/settings/theme');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $notifPrefsRoute => GoRouteData.$route(
  path: '/settings/notifications',

  factory: $NotifPrefsRouteExtension._fromState,
);

extension $NotifPrefsRouteExtension on NotifPrefsRoute {
  static NotifPrefsRoute _fromState(GoRouterState state) =>
      const NotifPrefsRoute();

  String get location => GoRouteData.$location('/settings/notifications');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dataExportRoute => GoRouteData.$route(
  path: '/settings/export',

  factory: $DataExportRouteExtension._fromState,
);

extension $DataExportRouteExtension on DataExportRoute {
  static DataExportRoute _fromState(GoRouterState state) =>
      const DataExportRoute();

  String get location => GoRouteData.$location('/settings/export');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $deleteAccountRoute => GoRouteData.$route(
  path: '/settings/delete',

  factory: $DeleteAccountRouteExtension._fromState,
);

extension $DeleteAccountRouteExtension on DeleteAccountRoute {
  static DeleteAccountRoute _fromState(GoRouterState state) =>
      const DeleteAccountRoute();

  String get location => GoRouteData.$location('/settings/delete');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $aboutRoute => GoRouteData.$route(
  path: '/settings/about',

  factory: $AboutRouteExtension._fromState,
);

extension $AboutRouteExtension on AboutRoute {
  static AboutRoute _fromState(GoRouterState state) => const AboutRoute();

  String get location => GoRouteData.$location('/settings/about');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $categoriesRoute => GoRouteData.$route(
  path: '/categories',

  factory: $CategoriesRouteExtension._fromState,
);

extension $CategoriesRouteExtension on CategoriesRoute {
  static CategoriesRoute _fromState(GoRouterState state) =>
      const CategoriesRoute();

  String get location => GoRouteData.$location('/categories');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $recurringRoute => GoRouteData.$route(
  path: '/recurring',

  factory: $RecurringRouteExtension._fromState,
);

extension $RecurringRouteExtension on RecurringRoute {
  static RecurringRoute _fromState(GoRouterState state) =>
      const RecurringRoute();

  String get location => GoRouteData.$location('/recurring');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $insightsRoute => GoRouteData.$route(
  path: '/insights',

  factory: $InsightsRouteExtension._fromState,
);

extension $InsightsRouteExtension on InsightsRoute {
  static InsightsRoute _fromState(GoRouterState state) => const InsightsRoute();

  String get location => GoRouteData.$location('/insights');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $searchRoute => GoRouteData.$route(
  path: '/search',

  factory: $SearchRouteExtension._fromState,
);

extension $SearchRouteExtension on SearchRoute {
  static SearchRoute _fromState(GoRouterState state) => const SearchRoute();

  String get location => GoRouteData.$location('/search');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $networkErrorRoute => GoRouteData.$route(
  path: '/error/network',

  factory: $NetworkErrorRouteExtension._fromState,
);

extension $NetworkErrorRouteExtension on NetworkErrorRoute {
  static NetworkErrorRoute _fromState(GoRouterState state) =>
      const NetworkErrorRoute();

  String get location => GoRouteData.$location('/error/network');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $appLockRoute => GoRouteData.$route(
  path: '/lock',

  factory: $AppLockRouteExtension._fromState,
);

extension $AppLockRouteExtension on AppLockRoute {
  static AppLockRoute _fromState(GoRouterState state) => const AppLockRoute();

  String get location => GoRouteData.$location('/lock');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $familyInviteRoute => GoRouteData.$route(
  path: '/family/invite/:token',

  factory: $FamilyInviteRouteExtension._fromState,
);

extension $FamilyInviteRouteExtension on FamilyInviteRoute {
  static FamilyInviteRoute _fromState(GoRouterState state) =>
      FamilyInviteRoute(state.pathParameters['token']!);

  String get location =>
      GoRouteData.$location('/family/invite/${Uri.encodeComponent(token)}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $weeklyReportRoute => GoRouteData.$route(
  path: '/reports/weekly',

  factory: $WeeklyReportRouteExtension._fromState,
);

extension $WeeklyReportRouteExtension on WeeklyReportRoute {
  static WeeklyReportRoute _fromState(GoRouterState state) =>
      const WeeklyReportRoute();

  String get location => GoRouteData.$location('/reports/weekly');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $monthlyReportRoute => GoRouteData.$route(
  path: '/reports/monthly',

  factory: $MonthlyReportRouteExtension._fromState,
);

extension $MonthlyReportRouteExtension on MonthlyReportRoute {
  static MonthlyReportRoute _fromState(GoRouterState state) =>
      const MonthlyReportRoute();

  String get location => GoRouteData.$location('/reports/monthly');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $cashEnvelopesRoute => GoRouteData.$route(
  path: '/cash-envelopes',

  factory: $CashEnvelopesRouteExtension._fromState,
);

extension $CashEnvelopesRouteExtension on CashEnvelopesRoute {
  static CashEnvelopesRoute _fromState(GoRouterState state) =>
      const CashEnvelopesRoute();

  String get location => GoRouteData.$location('/cash-envelopes');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $remittanceNotebookRoute => GoRouteData.$route(
  path: '/remittance-notebook',

  factory: $RemittanceNotebookRouteExtension._fromState,
);

extension $RemittanceNotebookRouteExtension on RemittanceNotebookRoute {
  static RemittanceNotebookRoute _fromState(GoRouterState state) =>
      const RemittanceNotebookRoute();

  String get location => GoRouteData.$location('/remittance-notebook');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $monthlyCloseRoute => GoRouteData.$route(
  path: '/monthly-close',

  factory: $MonthlyCloseRouteExtension._fromState,
);

extension $MonthlyCloseRouteExtension on MonthlyCloseRoute {
  static MonthlyCloseRoute _fromState(GoRouterState state) =>
      const MonthlyCloseRoute();

  String get location => GoRouteData.$location('/monthly-close');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $subscriptionRoute => GoRouteData.$route(
  path: '/subscription',

  factory: $SubscriptionRouteExtension._fromState,
);

extension $SubscriptionRouteExtension on SubscriptionRoute {
  static SubscriptionRoute _fromState(GoRouterState state) =>
      const SubscriptionRoute();

  String get location => GoRouteData.$location('/subscription');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $exportControlRoute => GoRouteData.$route(
  path: '/export-control',

  factory: $ExportControlRouteExtension._fromState,
);

extension $ExportControlRouteExtension on ExportControlRoute {
  static ExportControlRoute _fromState(GoRouterState state) =>
      const ExportControlRoute();

  String get location => GoRouteData.$location('/export-control');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
