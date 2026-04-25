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
  $doHubRoute,
  $notificationsRoute,
  $accountsRoute,
  $billsRoute,
  $sendRoute,
  $budgetsRoute,
  $goalsRoute,
  $transactionsRoute,
  $smsParserRoute,
  $coachRoute,
  $familyRoute,
  $profileRoute,
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

RouteBase get $sendRoute => GoRouteData.$route(
  path: '/send',

  factory: $SendRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: 'amount',

      factory: $SendAmountRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'review',

      factory: $SendReviewRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'success',

      factory: $SendSuccessRouteExtension._fromState,
    ),
  ],
);

extension $SendRouteExtension on SendRoute {
  static SendRoute _fromState(GoRouterState state) => const SendRoute();

  String get location => GoRouteData.$location('/send');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SendAmountRouteExtension on SendAmountRoute {
  static SendAmountRoute _fromState(GoRouterState state) =>
      const SendAmountRoute();

  String get location => GoRouteData.$location('/send/amount');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SendReviewRouteExtension on SendReviewRoute {
  static SendReviewRoute _fromState(GoRouterState state) =>
      const SendReviewRoute();

  String get location => GoRouteData.$location('/send/review');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SendSuccessRouteExtension on SendSuccessRoute {
  static SendSuccessRoute _fromState(GoRouterState state) =>
      const SendSuccessRoute();

  String get location => GoRouteData.$location('/send/success');

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
