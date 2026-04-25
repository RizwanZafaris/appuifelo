// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Felo';

  @override
  String get navHome => 'Home';

  @override
  String get navActivity => 'Activity';

  @override
  String get navBudgets => 'Budgets';

  @override
  String get navCoach => 'Coach';

  @override
  String get navGoals => 'Goals';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonGetStarted => 'Get started';

  @override
  String get commonCreateAccount => 'Create account';

  @override
  String get commonSignIn => 'Sign in';

  @override
  String get commonBack => 'Back';

  @override
  String get commonSkip => 'Skip for now';

  @override
  String get commonComingSoon => 'Coming soon';

  @override
  String get commonView => 'View';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSearch => 'Search';

  @override
  String get currencyCad => 'CAD';

  @override
  String get splashTitle => 'Money feels calmer when it is understood.';

  @override
  String get splashBody =>
      'Budget, track expenses, plan goals, and learn from your money without Felo ever holding it.';

  @override
  String get splashTrust => 'No custody. No money movement in Phase 1.';

  @override
  String get onboardingTitle => 'Set up Felo';

  @override
  String get onboardingSubtitle =>
      'A calm personal finance companion for households across Canada and Pakistan.';

  @override
  String get onboardingSlideOneTitle => 'See the full picture';

  @override
  String get onboardingSlideOneBody =>
      'Bring accounts, wallets, and manual entries into one read-only view.';

  @override
  String get onboardingSlideTwoTitle => 'Plan with envelopes';

  @override
  String get onboardingSlideTwoBody =>
      'Give every rupee or dollar a job with budgets, alerts, and shared goals.';

  @override
  String get onboardingSlideThreeTitle => 'Parse payment SMS safely';

  @override
  String get onboardingSlideThreeBody =>
      'On Android, Felo reads transaction alerts from Easypaisa, JazzCash, and banks. Personal messages and OTPs stay out.';

  @override
  String get onboardingSlideFourTitle => 'Learn without advice';

  @override
  String get onboardingSlideFourBody =>
      'Coach explains patterns and trade-offs. It does not recommend investments, insurance, or tax actions.';

  @override
  String get smsTrustTitle => 'SMS stays on your phone';

  @override
  String get smsTrustBody =>
      'We extract amount, merchant, date, and source. Full messages are not uploaded in this phase.';

  @override
  String get smsPatternOne => 'Reads: Easypaisa and JazzCash payment alerts';

  @override
  String get smsPatternTwo => 'Reads: bank debit and credit alerts';

  @override
  String get smsPatternThree => 'Does not read: OTPs or personal conversations';

  @override
  String get smsRevoke => 'You can revoke access in Android settings anytime.';

  @override
  String get authTitle => 'Welcome back';

  @override
  String get authBody =>
      'Email, Google, and Apple sign-in are scaffolded for Firebase Auth. This build uses mock sessions.';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authForgot => 'Forgot password';

  @override
  String get authGoogle => 'Continue with Google';

  @override
  String get authApple => 'Continue with Apple';

  @override
  String get homeTitle => 'Today';

  @override
  String get homeGreeting => 'Assalam-o-alaikum, Rizwan';

  @override
  String get homeNetPosition => 'Across connected accounts';

  @override
  String get homeSpendThisMonth => 'This month spend';

  @override
  String get homeBudgetLeft => 'Budget left';

  @override
  String get homeRecent => 'Recent transactions';

  @override
  String get homeTopBudgets => 'Top budgets';

  @override
  String get homeFamilyMode => 'Family mode';

  @override
  String get homeSmsStatus => 'SMS parser';

  @override
  String get homeRemittanceStub => 'Remittance waitlist';

  @override
  String get homeProfile => 'Profile settings';

  @override
  String get hubTitle => 'Explore Felo';

  @override
  String get budgetsTitle => 'Budgets';

  @override
  String get budgetsBody =>
      'Envelope-style budgets with rollover and alert controls.';

  @override
  String get budgetDetailTitle => 'Budget detail';

  @override
  String get budgetFormTitle => 'Create budget';

  @override
  String get budgetRollover => 'Rollover';

  @override
  String get goalsTitle => 'Goals';

  @override
  String get goalsBody =>
      'Mental-accounting goals. Money stays in the user\'s own account.';

  @override
  String get goalDetailTitle => 'Goal detail';

  @override
  String get transactionsTitle => 'Transactions';

  @override
  String get transactionsBody =>
      'Filter by date, category, account, or source.';

  @override
  String get transactionDetailTitle => 'Transaction detail';

  @override
  String get transactionSplit => 'Split';

  @override
  String get transactionRecategorize => 'Recategorize';

  @override
  String get smsParserTitle => 'SMS parser';

  @override
  String get smsParserBody =>
      'Android-only parser is stubbed from a local fixture for Phase 1.';

  @override
  String get smsParserAccuracy => 'Parser accuracy';

  @override
  String get coachTitle => 'Felo Coach';

  @override
  String get coachDisclaimer =>
      'Education only. Felo does not provide financial, investment, tax, or legal advice.';

  @override
  String get coachPromptOne => 'Where did my money go this week?';

  @override
  String get coachPromptTwo => 'How are my goals pacing?';

  @override
  String get coachPromptThree => 'Can I send extra this month?';

  @override
  String get coachInputHint => 'Ask about spending, budgets, or goals';

  @override
  String get familyTitle => 'Family mode';

  @override
  String get familyBody =>
      'Invite household members with consent-based permissions.';

  @override
  String get familyInvite => 'Invite with link';

  @override
  String get familyAdmin => 'Admin';

  @override
  String get familyMember => 'Member';

  @override
  String get familyViewer => 'Viewer';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profileTheme => 'Theme';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileLogout => 'Log out';

  @override
  String get profileDelete => 'Delete account';

  @override
  String get remittanceTitle => 'Send money home';

  @override
  String get remittanceBody =>
      'Phase 3 will orchestrate remittance through licensed partners. This build has no money movement.';

  @override
  String get remittanceCta => 'Join waitlist';

  @override
  String get emptyTitle => 'Nothing here yet';

  @override
  String get emptyBody =>
      'Seeded mock data will appear as each feature becomes active.';

  @override
  String get sampleDesignLabel => 'Sample design';

  @override
  String get sampleDashboardAmount => 'CAD 4,280';

  @override
  String get sampleBudgetAmount => 'CAD 1,840 left';

  @override
  String get sampleGoalName => 'Trip to Pakistan';

  @override
  String get sampleOnTrack => 'On track';
}
