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
  String get receiptCaptureTitle => 'Receipt capture';

  @override
  String get receiptCaptureBody =>
      'Attach a receipt image to improve transaction history. This OCR flow is stubbed with local mock data.';

  @override
  String get receiptUseCamera => 'Use camera';

  @override
  String get receiptUseGallery => 'Choose from gallery';

  @override
  String get receiptProcessing => 'Processing receipt...';

  @override
  String get receiptOcrResultTitle => 'Mock OCR result';

  @override
  String get receiptMerchantLabel => 'Merchant';

  @override
  String get receiptDateLabel => 'Date';

  @override
  String get receiptTotalLabel => 'Total';

  @override
  String get receiptLineItemsTitle => 'Line items';

  @override
  String get receiptConfirm => 'Confirm receipt';

  @override
  String get receiptDiscard => 'Discard receipt';

  @override
  String get receiptEditTitle => 'Edit OCR result';

  @override
  String get receiptAttached => 'Receipt attached';

  @override
  String get receiptConfirmedTitle => 'Receipt confirmed';

  @override
  String receiptConfirmedBody(String referenceId) {
    return 'Attached receipt reference $referenceId to this transaction.';
  }

  @override
  String get billsTitle => 'Bills';

  @override
  String get billsAddBill => 'Add bill';

  @override
  String get billsEmptyTitle => 'No bills yet';

  @override
  String get billsEmptyBody =>
      'Manual and SMS-detected bills will appear here before their due dates.';

  @override
  String get billsCalendarTitle => 'Due dates this month';

  @override
  String get billsNameLabel => 'Bill name';

  @override
  String get billsAmountLabel => 'Amount';

  @override
  String get billsDueDayLabel => 'Due day';

  @override
  String get billsManualNameFallback => 'Manual bill';

  @override
  String billsDueDate(String date) {
    return 'Due $date';
  }

  @override
  String get billsAutoPayOn => 'Auto-pay on';

  @override
  String get billsAutoPayOff => 'Auto-pay off';

  @override
  String get billsStatusPaid => 'Paid';

  @override
  String get billsStatusUpcoming => 'Upcoming';

  @override
  String get billsSourceManual => 'Manual';

  @override
  String get billsSourceSms => 'SMS';

  @override
  String get billsCategoryUtility => 'Utility';

  @override
  String get billsCategoryTelecom => 'Telecom';

  @override
  String get billsCategoryRent => 'Rent';

  @override
  String get billsCategorySubscription => 'Subscription';

  @override
  String get billsPayPreview => 'Pay preview';

  @override
  String get billsPayPreviewBody =>
      'This is a bill-management preview only. No payment is initiated and no money is moved.';

  @override
  String get billsMarkPaid => 'Mark paid';

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
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsBellTooltip => 'Open notifications';

  @override
  String get notificationsMarkAllRead => 'Mark all read';

  @override
  String get notificationsMarkRead => 'Mark read';

  @override
  String get notificationsArchive => 'Archive';

  @override
  String notificationsUnreadCount(int count) {
    return '$count unread';
  }

  @override
  String get notificationsEmptyTitle => 'No notifications';

  @override
  String get notificationsEmptyBody =>
      'Budget alerts, goal milestones, SMS parser events, and family activity will appear here.';

  @override
  String get notificationsFilterAll => 'All';

  @override
  String get notificationsFilterBudgets => 'Budgets';

  @override
  String get notificationsFilterGoals => 'Goals';

  @override
  String get notificationsFilterFamily => 'Family';

  @override
  String get notificationsFilterSystem => 'System';

  @override
  String notificationsTimestamp(String date, String time) {
    return '$date · $time';
  }

  @override
  String get notificationBudgetTitle => 'Budget alert';

  @override
  String notificationBudgetBody(String category, int percent) {
    return '$category reached $percent% of its envelope.';
  }

  @override
  String get notificationGoalTitle => 'Goal milestone';

  @override
  String notificationGoalBody(String goalName, int percent) {
    return '$goalName crossed $percent% funded.';
  }

  @override
  String get notificationSmsParserTitle => 'SMS parser event';

  @override
  String notificationSmsParserBody(String source, int confidence) {
    return '$source parsed a transaction with $confidence% confidence.';
  }

  @override
  String get notificationFamilyTitle => 'Family activity';

  @override
  String notificationFamilyBody(String memberName) {
    return '$memberName changed shared family permissions.';
  }

  @override
  String get notificationSystemTitle => 'System message';

  @override
  String get notificationSystemBody =>
      'Phase 1 keeps payments, custody, and money movement turned off.';

  @override
  String get accountsTitle => 'Accounts';

  @override
  String get accountsConnect => 'Connect account';

  @override
  String get accountsConnectTitle => 'Connect account';

  @override
  String get accountsEmptyTitle => 'No connected accounts';

  @override
  String get accountsEmptyBody =>
      'Connect read-only accounts or add a manual account to make the dashboard more useful.';

  @override
  String accountsLastSynced(String date, String time) {
    return 'Synced $date at $time';
  }

  @override
  String get accountsTypeBank => 'Bank';

  @override
  String get accountsTypeCard => 'Card';

  @override
  String get accountsTypeWallet => 'Wallet';

  @override
  String get accountsStatusSynced => 'Synced';

  @override
  String get accountsStatusSyncing => 'Syncing';

  @override
  String get accountsStatusNeedsReview => 'Review';

  @override
  String get accountsDisconnect => 'Disconnect';

  @override
  String get accountsDisconnectTitle => 'Disconnect account';

  @override
  String accountsDisconnectBody(String accountName) {
    return 'Remove $accountName from this mock read-only view?';
  }

  @override
  String get accountsProviderPickerTitle => 'Choose a provider';

  @override
  String get accountsProviderTd => 'TD';

  @override
  String get accountsProviderRbc => 'RBC';

  @override
  String get accountsProviderEasypaisa => 'Easypaisa';

  @override
  String get accountsProviderJazzcash => 'JazzCash';

  @override
  String get accountsProviderManual => 'Manual';

  @override
  String accountsMockOAuthTitle(String providerName) {
    return '$providerName secure preview';
  }

  @override
  String get accountsMockOAuthBody =>
      'This screen simulates a read-only provider connection. No credentials are collected in this build.';

  @override
  String get accountsConnectContinue => 'Continue preview';

  @override
  String get accountsConnectSuccessTitle => 'Account connected';

  @override
  String accountsConnectSuccessBody(String accountName) {
    return '$accountName is now available in the mock account list.';
  }

  @override
  String get accountsViewAccounts => 'View accounts';

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
