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
  String get navDo => 'Do';

  @override
  String get navGoals => 'Goals';

  @override
  String get complianceFooter =>
      'Registration pending · MSB application in progress.';

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
  String get doHubTitle => 'Do';

  @override
  String get doHubSubtitle =>
      'Everything you can act on, grouped into simple aisles.';

  @override
  String get doHubSendPay => 'Send & Pay';

  @override
  String get doHubSendPayBody => 'Remittance, bills, and split payments.';

  @override
  String get doHubSaveTrack => 'Save & Track';

  @override
  String get doHubSaveTrackBody => 'Goals, round-ups, and investment tracking.';

  @override
  String get doHubSpendSmart => 'Spend Smart';

  @override
  String get doHubSpendSmartBody => 'Budgets, subscriptions, and insights.';

  @override
  String get doHubCardsAccounts => 'Cards & Accounts';

  @override
  String get doHubCardsAccountsBody =>
      'Linked banks, cards, and account controls.';

  @override
  String get doHubMoreHelp => 'More & Help';

  @override
  String get doHubMoreHelpBody => 'Support, referrals, and Felo Plus.';

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
  String goalStreakBadge(int weeks) {
    return '$weeks-week streak';
  }

  @override
  String goalProgressSummary(String saved, String target) {
    return '$saved saved of $target';
  }

  @override
  String get goalContributorsTitle => 'Contributors';

  @override
  String get goalContributeButton => 'Contribute';

  @override
  String get goalContributionSheetTitle => 'Add to goal';

  @override
  String get goalContributionAmountLabel => 'Amount';

  @override
  String get goalContributionBefore => 'Before';

  @override
  String get goalContributionAfter => 'After';

  @override
  String get goalContributionSaved => 'Contribution added.';

  @override
  String get goalContributionFailed =>
      'Contribution could not be added. Try again.';

  @override
  String get goalMilestoneDialogTitle => 'Milestone reached';

  @override
  String goalMilestoneDialogBody(String goalName, int percent) {
    return '$goalName reached $percent%.';
  }

  @override
  String get goalCardTeaserTitle => 'Card round-ups can boost this goal';

  @override
  String goalCardTeaserBody(String goalName) {
    return 'When Felo Card launches, spare change from purchases can flow into $goalName.';
  }

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
  String get sendTitle => 'Send money';

  @override
  String get sendPickRecipientTitle => 'Pick recipient';

  @override
  String get sendAddRecipient => 'Add new recipient';

  @override
  String get sendRecipientNameLabel => 'Recipient name';

  @override
  String get sendRecipientPhoneLabel => 'Phone';

  @override
  String get sendRecipientFallback => 'New recipient';

  @override
  String get sendRecipientPhoneFallback => '+92 *** *** ****';

  @override
  String get sendAmountTitle => 'Enter amount';

  @override
  String get sendNoRecipientTitle => 'Choose a recipient first';

  @override
  String get sendNoRecipientBody =>
      'The preview needs a saved or newly added recipient before amount entry.';

  @override
  String get sendAmountLabel => 'Amount in CAD';

  @override
  String get sendFxPreviewEmpty => 'Enter an amount to preview PKR';

  @override
  String sendFxPreview(String amount) {
    return 'Recipient gets about $amount';
  }

  @override
  String sendFxRate(String sourceCurrency, String rate, String targetCurrency) {
    return 'Mock rate: 1 $sourceCurrency = $rate $targetCurrency';
  }

  @override
  String get sendReviewTitle => 'Review preview';

  @override
  String get sendReviewMissingTitle => 'Preview not ready';

  @override
  String get sendReviewMissingBody =>
      'Choose a recipient and amount before reviewing.';

  @override
  String get sendRecipientLabel => 'Recipient';

  @override
  String get sendRecipientGetsLabel => 'Recipient gets';

  @override
  String get sendPreviewDisclaimer =>
      'This is a preview. No money is moved. Phase 3 will require licensed partners before any transfer flow exists.';

  @override
  String get sendConfirmPreview => 'Confirm preview';

  @override
  String get sendSuccessTitle => 'Preview created';

  @override
  String sendSuccessBody(String referenceId) {
    return 'Reference $referenceId is for this preview only. No money was moved.';
  }

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

  @override
  String get commonDone => 'Done';

  @override
  String get helpTitle => 'Help & support';

  @override
  String get helpSearchLabel => 'Search help';

  @override
  String get helpSearchHint => 'Type a question or keyword';

  @override
  String get helpNoResults => 'No results yet — try a different search.';

  @override
  String get helpContactSupport => 'Contact support';

  @override
  String get helpReportBug => 'Report a bug';

  @override
  String get helpTerms => 'Terms';

  @override
  String get helpPrivacy => 'Privacy';

  @override
  String get helpLicenses => 'Licenses';

  @override
  String get helpFaq1Q => 'Is Felo a bank?';

  @override
  String get helpFaq1A =>
      'No. Felo is a budgeting and goal companion. We never hold or move your money.';

  @override
  String get helpFaq2Q => 'How does SMS parsing work?';

  @override
  String get helpFaq2A =>
      'On Android, Felo reads SMS from saved bank and wallet senders on your device. SMS bodies never leave your phone in Phase 1.';

  @override
  String get helpFaq3Q => 'Can my family see my transactions?';

  @override
  String get helpFaq3A =>
      'Only if you invite them and explicitly enable shared visibility. You can revoke access at any time.';

  @override
  String get helpFaq4Q => 'How do I change language?';

  @override
  String get helpFaq4A =>
      'Open Profile → Settings → Language. Felo supports English and Urdu (RTL).';

  @override
  String get helpFaq5Q => 'What happens if I delete my account?';

  @override
  String get helpFaq5A =>
      'Your data is soft-deleted for 30 days, then permanently erased. You can export everything before deletion.';

  @override
  String get kycTitle => 'Verify your identity';

  @override
  String get kycChooseIdType => 'Choose ID type';

  @override
  String get kycIdPassport => 'Passport';

  @override
  String get kycIdCnic => 'Pakistani CNIC';

  @override
  String get kycIdDriversLicense => 'Driver\'s license';

  @override
  String get kycCaptureIdTitle => 'Capture your ID';

  @override
  String get kycCaptureFront => 'Capture front';

  @override
  String get kycCaptureBack => 'Capture back';

  @override
  String get kycSelfieTitle => 'Take a selfie';

  @override
  String get kycCaptureSelfie => 'Capture selfie';

  @override
  String get kycSelfieHint =>
      'Look straight at the camera in good light. Glasses off.';

  @override
  String get kycReviewTitle => 'Review and submit';

  @override
  String get kycReviewIdType => 'ID type';

  @override
  String get kycReviewIdImages => 'ID images';

  @override
  String get kycReviewSelfie => 'Selfie';

  @override
  String get kycReviewCaptured => 'Captured';

  @override
  String get kycReviewMissing => 'Missing';

  @override
  String get kycReviewDisclaimer =>
      'Submitting sends data to a verification partner. Phase 1 builds use a stub — no data leaves the device.';

  @override
  String get kycSubmit => 'Submit';

  @override
  String get kycSubmittedTitle => 'Submitted for review';

  @override
  String get kycSubmittedBody =>
      'We\'ll notify you when verification completes. You can keep using budgeting features in the meantime.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get forgotPasswordTitle => 'Reset password';

  @override
  String get forgotPasswordBody =>
      'Enter the email tied to your Felo account. We\'ll send you a reset link.';

  @override
  String get forgotPasswordSendCta => 'Send reset link';

  @override
  String get forgotPasswordSentTitle => 'Check your inbox';

  @override
  String get forgotPasswordSentBody =>
      'If an account exists for that email, a reset link is on its way. The link expires in 30 minutes.';

  @override
  String get emailVerifyTitle => 'Verify email';

  @override
  String get emailVerifyHeading => 'Confirm your email';

  @override
  String get emailVerifyBody =>
      'Tap the link in the email we just sent to finish setting up your Felo account.';

  @override
  String get emailVerifyResend => 'Resend email';

  @override
  String emailVerifyResendIn(String seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get mfaTitle => 'Two-factor authentication';

  @override
  String get mfaBody =>
      'Scan the QR code with an authenticator app, then enter the 6-digit code to confirm.';

  @override
  String get mfaCopySecret => 'Copy secret key';

  @override
  String get mfaSecretCopied => 'Secret copied';

  @override
  String get mfaCodeLabel => '6-digit code';

  @override
  String get mfaVerifyCta => 'Verify code';

  @override
  String get mfaVerified => 'Two-factor enabled';

  @override
  String get biometricTitle => 'App lock';

  @override
  String get biometricBody => 'Add a biometric lock so only you can open Felo.';

  @override
  String get biometricEnable => 'Use biometric unlock';

  @override
  String get biometricAutoLock => 'Auto-lock after';

  @override
  String get biometricImmediate => 'Immediately';

  @override
  String get biometricAfter1Min => '1 minute of inactivity';

  @override
  String get biometricAfter5Min => '5 minutes of inactivity';

  @override
  String get biometricAfter15Min => '15 minutes of inactivity';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageUrdu => 'Urdu (اردو)';

  @override
  String get languageHelper =>
      'We localize numbers and currencies, but never translate amounts.';

  @override
  String get themeTitle => 'Theme';

  @override
  String get themeSystem => 'Match system';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get notifPrefsTitle => 'Notification preferences';

  @override
  String get notifPrefsBudgets => 'Budget alerts';

  @override
  String get notifPrefsGoals => 'Goal milestones';

  @override
  String get notifPrefsFamily => 'Family activity';

  @override
  String get notifPrefsCoach => 'Coach nudges';

  @override
  String get notifPrefsSystem => 'System & security';

  @override
  String get notifPrefsQuietHours => 'Quiet hours';

  @override
  String get notifPrefsQuietHoursHelper =>
      'Mute non-critical alerts overnight (10pm–7am).';

  @override
  String get dataExportTitle => 'Export your data';

  @override
  String get dataExportBody =>
      'We\'ll prepare a downloadable archive of everything tied to your account.';

  @override
  String get dataExportScopeAll => 'Everything';

  @override
  String get dataExportScopeTransactions => 'Transactions only';

  @override
  String get dataExportScopeBudgets => 'Budgets only';

  @override
  String get dataExportScopeGoals => 'Goals only';

  @override
  String get dataExportRequestCta => 'Request export';

  @override
  String get dataExportRequested => 'Export requested';

  @override
  String get dataExportEta => 'We\'ll email you a link within 24 hours.';

  @override
  String get deleteAccountTitle => 'Delete account';

  @override
  String get deleteAccountWarningTitle => 'This is permanent after 30 days.';

  @override
  String get deleteAccountWarningBody =>
      'Your data is soft-deleted immediately and fully erased after 30 days. You can cancel during the grace period by signing in.';

  @override
  String get deleteAccountTypePrompt => 'Type DELETE in capitals to confirm.';

  @override
  String get deleteAccountConfirmLabel => 'Type DELETE';

  @override
  String get deleteAccountCta => 'Delete my account';

  @override
  String get deleteAccountSubmittedTitle => 'Account scheduled for deletion';

  @override
  String get deleteAccountSubmittedBody =>
      'We\'ve signed you out. You\'ll receive a confirmation email shortly.';

  @override
  String get aboutTitle => 'About Felo';

  @override
  String get aboutTagline =>
      'A no-custody money companion for the Pakistani diaspora.';

  @override
  String get aboutVersion => 'Version';

  @override
  String get aboutBuild => 'Build';

  @override
  String get aboutCopyright => 'Copyright';

  @override
  String get categoriesTitle => 'Categories';

  @override
  String get categoriesAdd => 'Add category';

  @override
  String get recurringTitle => 'Recurring';

  @override
  String get recurringBody =>
      'Subscriptions and bills we\'ve spotted in your activity.';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get insightsThisMonth => 'Spent this month';

  @override
  String get insightsByCategory => 'By category';

  @override
  String get searchTitle => 'Search';

  @override
  String get searchLabel => 'Search Felo';

  @override
  String get searchHint => 'Merchant, category, goal…';

  @override
  String get searchPrompt => 'Type at least one character to search.';

  @override
  String get searchEmptyTitle => 'No matches';

  @override
  String get searchEmptyBody => 'Try a different keyword.';

  @override
  String get searchTransactions => 'Transactions';

  @override
  String get searchBudgets => 'Budgets';

  @override
  String get searchGoals => 'Goals';

  @override
  String get networkErrorTitle => 'Connection issue';

  @override
  String get networkErrorHeading => 'We can\'t reach the network';

  @override
  String get networkErrorBody =>
      'Felo works offline for cached data — try again to sync.';

  @override
  String get networkErrorRetry => 'Try again';

  @override
  String get appLockTitle => 'App locked';

  @override
  String get appLockHeading => 'Welcome back';

  @override
  String get appLockPinLabel => 'Enter PIN';

  @override
  String get appLockUnlock => 'Unlock';

  @override
  String get appLockUseBiometric => 'Use biometric';

  @override
  String get appLockWrongPin => 'Wrong PIN. Try again.';

  @override
  String get familyInviteTitle => 'Family invite';

  @override
  String get familyInviteFromHeading => 'You\'ve been invited';

  @override
  String get familyInviteDescription =>
      'Join a family group to share visibility on selected budgets and goals.';

  @override
  String get familyInvitePermViewTxns => 'View shared transactions';

  @override
  String get familyInvitePermViewBudgets => 'View shared budgets';

  @override
  String get familyInvitePermEditBudgets => 'Edit shared budgets';

  @override
  String get familyInviteAcceptCta => 'Accept invite';

  @override
  String get familyInviteDeclineCta => 'Decline';

  @override
  String get familyInviteAccepted => 'You\'re now part of the family group.';

  @override
  String familyInviteTokenHint(String token) {
    return 'Invite token: $token';
  }
}
