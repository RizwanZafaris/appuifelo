import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ur'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Felo'**
  String get appName;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get navActivity;

  /// No description provided for @navBudgets.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get navBudgets;

  /// No description provided for @navCoach.
  ///
  /// In en, this message translates to:
  /// **'Coach'**
  String get navCoach;

  /// No description provided for @navGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get navGoals;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get commonGetStarted;

  /// No description provided for @commonCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get commonCreateAccount;

  /// No description provided for @commonSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get commonSignIn;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get commonSkip;

  /// No description provided for @commonComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get commonComingSoon;

  /// No description provided for @commonView.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get commonView;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get commonSearch;

  /// No description provided for @currencyCad.
  ///
  /// In en, this message translates to:
  /// **'CAD'**
  String get currencyCad;

  /// No description provided for @splashTitle.
  ///
  /// In en, this message translates to:
  /// **'Money feels calmer when it is understood.'**
  String get splashTitle;

  /// No description provided for @splashBody.
  ///
  /// In en, this message translates to:
  /// **'Budget, track expenses, plan goals, and learn from your money without Felo ever holding it.'**
  String get splashBody;

  /// No description provided for @splashTrust.
  ///
  /// In en, this message translates to:
  /// **'No custody. No money movement in Phase 1.'**
  String get splashTrust;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up Felo'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A calm personal finance companion for households across Canada and Pakistan.'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingSlideOneTitle.
  ///
  /// In en, this message translates to:
  /// **'See the full picture'**
  String get onboardingSlideOneTitle;

  /// No description provided for @onboardingSlideOneBody.
  ///
  /// In en, this message translates to:
  /// **'Bring accounts, wallets, and manual entries into one read-only view.'**
  String get onboardingSlideOneBody;

  /// No description provided for @onboardingSlideTwoTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan with envelopes'**
  String get onboardingSlideTwoTitle;

  /// No description provided for @onboardingSlideTwoBody.
  ///
  /// In en, this message translates to:
  /// **'Give every rupee or dollar a job with budgets, alerts, and shared goals.'**
  String get onboardingSlideTwoBody;

  /// No description provided for @onboardingSlideThreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Parse payment SMS safely'**
  String get onboardingSlideThreeTitle;

  /// No description provided for @onboardingSlideThreeBody.
  ///
  /// In en, this message translates to:
  /// **'On Android, Felo reads transaction alerts from Easypaisa, JazzCash, and banks. Personal messages and OTPs stay out.'**
  String get onboardingSlideThreeBody;

  /// No description provided for @onboardingSlideFourTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn without advice'**
  String get onboardingSlideFourTitle;

  /// No description provided for @onboardingSlideFourBody.
  ///
  /// In en, this message translates to:
  /// **'Coach explains patterns and trade-offs. It does not recommend investments, insurance, or tax actions.'**
  String get onboardingSlideFourBody;

  /// No description provided for @smsTrustTitle.
  ///
  /// In en, this message translates to:
  /// **'SMS stays on your phone'**
  String get smsTrustTitle;

  /// No description provided for @smsTrustBody.
  ///
  /// In en, this message translates to:
  /// **'We extract amount, merchant, date, and source. Full messages are not uploaded in this phase.'**
  String get smsTrustBody;

  /// No description provided for @smsPatternOne.
  ///
  /// In en, this message translates to:
  /// **'Reads: Easypaisa and JazzCash payment alerts'**
  String get smsPatternOne;

  /// No description provided for @smsPatternTwo.
  ///
  /// In en, this message translates to:
  /// **'Reads: bank debit and credit alerts'**
  String get smsPatternTwo;

  /// No description provided for @smsPatternThree.
  ///
  /// In en, this message translates to:
  /// **'Does not read: OTPs or personal conversations'**
  String get smsPatternThree;

  /// No description provided for @smsRevoke.
  ///
  /// In en, this message translates to:
  /// **'You can revoke access in Android settings anytime.'**
  String get smsRevoke;

  /// No description provided for @authTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authTitle;

  /// No description provided for @authBody.
  ///
  /// In en, this message translates to:
  /// **'Email, Google, and Apple sign-in are scaffolded for Firebase Auth. This build uses mock sessions.'**
  String get authBody;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authForgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get authForgot;

  /// No description provided for @authGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authGoogle;

  /// No description provided for @authApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get authApple;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get homeTitle;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Assalam-o-alaikum, Rizwan'**
  String get homeGreeting;

  /// No description provided for @homeNetPosition.
  ///
  /// In en, this message translates to:
  /// **'Across connected accounts'**
  String get homeNetPosition;

  /// No description provided for @homeSpendThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month spend'**
  String get homeSpendThisMonth;

  /// No description provided for @homeBudgetLeft.
  ///
  /// In en, this message translates to:
  /// **'Budget left'**
  String get homeBudgetLeft;

  /// No description provided for @homeRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent transactions'**
  String get homeRecent;

  /// No description provided for @homeTopBudgets.
  ///
  /// In en, this message translates to:
  /// **'Top budgets'**
  String get homeTopBudgets;

  /// No description provided for @homeFamilyMode.
  ///
  /// In en, this message translates to:
  /// **'Family mode'**
  String get homeFamilyMode;

  /// No description provided for @homeSmsStatus.
  ///
  /// In en, this message translates to:
  /// **'SMS parser'**
  String get homeSmsStatus;

  /// No description provided for @homeRemittanceStub.
  ///
  /// In en, this message translates to:
  /// **'Remittance waitlist'**
  String get homeRemittanceStub;

  /// No description provided for @homeProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile settings'**
  String get homeProfile;

  /// No description provided for @hubTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore Felo'**
  String get hubTitle;

  /// No description provided for @budgetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get budgetsTitle;

  /// No description provided for @budgetsBody.
  ///
  /// In en, this message translates to:
  /// **'Envelope-style budgets with rollover and alert controls.'**
  String get budgetsBody;

  /// No description provided for @budgetDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Budget detail'**
  String get budgetDetailTitle;

  /// No description provided for @budgetFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Create budget'**
  String get budgetFormTitle;

  /// No description provided for @budgetRollover.
  ///
  /// In en, this message translates to:
  /// **'Rollover'**
  String get budgetRollover;

  /// No description provided for @goalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goalsTitle;

  /// No description provided for @goalsBody.
  ///
  /// In en, this message translates to:
  /// **'Mental-accounting goals. Money stays in the user\'s own account.'**
  String get goalsBody;

  /// No description provided for @goalDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Goal detail'**
  String get goalDetailTitle;

  /// No description provided for @transactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactionsTitle;

  /// No description provided for @transactionsBody.
  ///
  /// In en, this message translates to:
  /// **'Filter by date, category, account, or source.'**
  String get transactionsBody;

  /// No description provided for @transactionDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction detail'**
  String get transactionDetailTitle;

  /// No description provided for @transactionSplit.
  ///
  /// In en, this message translates to:
  /// **'Split'**
  String get transactionSplit;

  /// No description provided for @transactionRecategorize.
  ///
  /// In en, this message translates to:
  /// **'Recategorize'**
  String get transactionRecategorize;

  /// No description provided for @receiptCaptureTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipt capture'**
  String get receiptCaptureTitle;

  /// No description provided for @receiptCaptureBody.
  ///
  /// In en, this message translates to:
  /// **'Attach a receipt image to improve transaction history. This OCR flow is stubbed with local mock data.'**
  String get receiptCaptureBody;

  /// No description provided for @receiptUseCamera.
  ///
  /// In en, this message translates to:
  /// **'Use camera'**
  String get receiptUseCamera;

  /// No description provided for @receiptUseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get receiptUseGallery;

  /// No description provided for @receiptProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing receipt...'**
  String get receiptProcessing;

  /// No description provided for @receiptOcrResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Mock OCR result'**
  String get receiptOcrResultTitle;

  /// No description provided for @receiptMerchantLabel.
  ///
  /// In en, this message translates to:
  /// **'Merchant'**
  String get receiptMerchantLabel;

  /// No description provided for @receiptDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get receiptDateLabel;

  /// No description provided for @receiptTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get receiptTotalLabel;

  /// No description provided for @receiptLineItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Line items'**
  String get receiptLineItemsTitle;

  /// No description provided for @receiptConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm receipt'**
  String get receiptConfirm;

  /// No description provided for @receiptDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard receipt'**
  String get receiptDiscard;

  /// No description provided for @receiptEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit OCR result'**
  String get receiptEditTitle;

  /// No description provided for @receiptAttached.
  ///
  /// In en, this message translates to:
  /// **'Receipt attached'**
  String get receiptAttached;

  /// No description provided for @receiptConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipt confirmed'**
  String get receiptConfirmedTitle;

  /// No description provided for @receiptConfirmedBody.
  ///
  /// In en, this message translates to:
  /// **'Attached receipt reference {referenceId} to this transaction.'**
  String receiptConfirmedBody(String referenceId);

  /// No description provided for @billsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get billsTitle;

  /// No description provided for @billsAddBill.
  ///
  /// In en, this message translates to:
  /// **'Add bill'**
  String get billsAddBill;

  /// No description provided for @billsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No bills yet'**
  String get billsEmptyTitle;

  /// No description provided for @billsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Manual and SMS-detected bills will appear here before their due dates.'**
  String get billsEmptyBody;

  /// No description provided for @billsCalendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Due dates this month'**
  String get billsCalendarTitle;

  /// No description provided for @billsNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Bill name'**
  String get billsNameLabel;

  /// No description provided for @billsAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get billsAmountLabel;

  /// No description provided for @billsDueDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Due day'**
  String get billsDueDayLabel;

  /// No description provided for @billsManualNameFallback.
  ///
  /// In en, this message translates to:
  /// **'Manual bill'**
  String get billsManualNameFallback;

  /// No description provided for @billsDueDate.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String billsDueDate(String date);

  /// No description provided for @billsAutoPayOn.
  ///
  /// In en, this message translates to:
  /// **'Auto-pay on'**
  String get billsAutoPayOn;

  /// No description provided for @billsAutoPayOff.
  ///
  /// In en, this message translates to:
  /// **'Auto-pay off'**
  String get billsAutoPayOff;

  /// No description provided for @billsStatusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get billsStatusPaid;

  /// No description provided for @billsStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get billsStatusUpcoming;

  /// No description provided for @billsSourceManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get billsSourceManual;

  /// No description provided for @billsSourceSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get billsSourceSms;

  /// No description provided for @billsCategoryUtility.
  ///
  /// In en, this message translates to:
  /// **'Utility'**
  String get billsCategoryUtility;

  /// No description provided for @billsCategoryTelecom.
  ///
  /// In en, this message translates to:
  /// **'Telecom'**
  String get billsCategoryTelecom;

  /// No description provided for @billsCategoryRent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get billsCategoryRent;

  /// No description provided for @billsCategorySubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get billsCategorySubscription;

  /// No description provided for @billsPayPreview.
  ///
  /// In en, this message translates to:
  /// **'Pay preview'**
  String get billsPayPreview;

  /// No description provided for @billsPayPreviewBody.
  ///
  /// In en, this message translates to:
  /// **'This is a bill-management preview only. No payment is initiated and no money is moved.'**
  String get billsPayPreviewBody;

  /// No description provided for @billsMarkPaid.
  ///
  /// In en, this message translates to:
  /// **'Mark paid'**
  String get billsMarkPaid;

  /// No description provided for @smsParserTitle.
  ///
  /// In en, this message translates to:
  /// **'SMS parser'**
  String get smsParserTitle;

  /// No description provided for @smsParserBody.
  ///
  /// In en, this message translates to:
  /// **'Android-only parser is stubbed from a local fixture for Phase 1.'**
  String get smsParserBody;

  /// No description provided for @smsParserAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Parser accuracy'**
  String get smsParserAccuracy;

  /// No description provided for @coachTitle.
  ///
  /// In en, this message translates to:
  /// **'Felo Coach'**
  String get coachTitle;

  /// No description provided for @coachDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Education only. Felo does not provide financial, investment, tax, or legal advice.'**
  String get coachDisclaimer;

  /// No description provided for @coachPromptOne.
  ///
  /// In en, this message translates to:
  /// **'Where did my money go this week?'**
  String get coachPromptOne;

  /// No description provided for @coachPromptTwo.
  ///
  /// In en, this message translates to:
  /// **'How are my goals pacing?'**
  String get coachPromptTwo;

  /// No description provided for @coachPromptThree.
  ///
  /// In en, this message translates to:
  /// **'Can I send extra this month?'**
  String get coachPromptThree;

  /// No description provided for @coachInputHint.
  ///
  /// In en, this message translates to:
  /// **'Ask about spending, budgets, or goals'**
  String get coachInputHint;

  /// No description provided for @familyTitle.
  ///
  /// In en, this message translates to:
  /// **'Family mode'**
  String get familyTitle;

  /// No description provided for @familyBody.
  ///
  /// In en, this message translates to:
  /// **'Invite household members with consent-based permissions.'**
  String get familyBody;

  /// No description provided for @familyInvite.
  ///
  /// In en, this message translates to:
  /// **'Invite with link'**
  String get familyInvite;

  /// No description provided for @familyAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get familyAdmin;

  /// No description provided for @familyMember.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get familyMember;

  /// No description provided for @familyViewer.
  ///
  /// In en, this message translates to:
  /// **'Viewer'**
  String get familyViewer;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsBellTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open notifications'**
  String get notificationsBellTooltip;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsMarkRead.
  ///
  /// In en, this message translates to:
  /// **'Mark read'**
  String get notificationsMarkRead;

  /// No description provided for @notificationsArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get notificationsArchive;

  /// No description provided for @notificationsUnreadCount.
  ///
  /// In en, this message translates to:
  /// **'{count} unread'**
  String notificationsUnreadCount(int count);

  /// No description provided for @notificationsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get notificationsEmptyTitle;

  /// No description provided for @notificationsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Budget alerts, goal milestones, SMS parser events, and family activity will appear here.'**
  String get notificationsEmptyBody;

  /// No description provided for @notificationsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notificationsFilterAll;

  /// No description provided for @notificationsFilterBudgets.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get notificationsFilterBudgets;

  /// No description provided for @notificationsFilterGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get notificationsFilterGoals;

  /// No description provided for @notificationsFilterFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get notificationsFilterFamily;

  /// No description provided for @notificationsFilterSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get notificationsFilterSystem;

  /// No description provided for @notificationsTimestamp.
  ///
  /// In en, this message translates to:
  /// **'{date} · {time}'**
  String notificationsTimestamp(String date, String time);

  /// No description provided for @notificationBudgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Budget alert'**
  String get notificationBudgetTitle;

  /// No description provided for @notificationBudgetBody.
  ///
  /// In en, this message translates to:
  /// **'{category} reached {percent}% of its envelope.'**
  String notificationBudgetBody(String category, int percent);

  /// No description provided for @notificationGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Goal milestone'**
  String get notificationGoalTitle;

  /// No description provided for @notificationGoalBody.
  ///
  /// In en, this message translates to:
  /// **'{goalName} crossed {percent}% funded.'**
  String notificationGoalBody(String goalName, int percent);

  /// No description provided for @notificationSmsParserTitle.
  ///
  /// In en, this message translates to:
  /// **'SMS parser event'**
  String get notificationSmsParserTitle;

  /// No description provided for @notificationSmsParserBody.
  ///
  /// In en, this message translates to:
  /// **'{source} parsed a transaction with {confidence}% confidence.'**
  String notificationSmsParserBody(String source, int confidence);

  /// No description provided for @notificationFamilyTitle.
  ///
  /// In en, this message translates to:
  /// **'Family activity'**
  String get notificationFamilyTitle;

  /// No description provided for @notificationFamilyBody.
  ///
  /// In en, this message translates to:
  /// **'{memberName} changed shared family permissions.'**
  String notificationFamilyBody(String memberName);

  /// No description provided for @notificationSystemTitle.
  ///
  /// In en, this message translates to:
  /// **'System message'**
  String get notificationSystemTitle;

  /// No description provided for @notificationSystemBody.
  ///
  /// In en, this message translates to:
  /// **'Phase 1 keeps payments, custody, and money movement turned off.'**
  String get notificationSystemBody;

  /// No description provided for @accountsTitle.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accountsTitle;

  /// No description provided for @accountsConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect account'**
  String get accountsConnect;

  /// No description provided for @accountsConnectTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect account'**
  String get accountsConnectTitle;

  /// No description provided for @accountsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No connected accounts'**
  String get accountsEmptyTitle;

  /// No description provided for @accountsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Connect read-only accounts or add a manual account to make the dashboard more useful.'**
  String get accountsEmptyBody;

  /// No description provided for @accountsLastSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced {date} at {time}'**
  String accountsLastSynced(String date, String time);

  /// No description provided for @accountsTypeBank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get accountsTypeBank;

  /// No description provided for @accountsTypeCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get accountsTypeCard;

  /// No description provided for @accountsTypeWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get accountsTypeWallet;

  /// No description provided for @accountsStatusSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get accountsStatusSynced;

  /// No description provided for @accountsStatusSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing'**
  String get accountsStatusSyncing;

  /// No description provided for @accountsStatusNeedsReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get accountsStatusNeedsReview;

  /// No description provided for @accountsDisconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get accountsDisconnect;

  /// No description provided for @accountsDisconnectTitle.
  ///
  /// In en, this message translates to:
  /// **'Disconnect account'**
  String get accountsDisconnectTitle;

  /// No description provided for @accountsDisconnectBody.
  ///
  /// In en, this message translates to:
  /// **'Remove {accountName} from this mock read-only view?'**
  String accountsDisconnectBody(String accountName);

  /// No description provided for @accountsProviderPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a provider'**
  String get accountsProviderPickerTitle;

  /// No description provided for @accountsProviderTd.
  ///
  /// In en, this message translates to:
  /// **'TD'**
  String get accountsProviderTd;

  /// No description provided for @accountsProviderRbc.
  ///
  /// In en, this message translates to:
  /// **'RBC'**
  String get accountsProviderRbc;

  /// No description provided for @accountsProviderEasypaisa.
  ///
  /// In en, this message translates to:
  /// **'Easypaisa'**
  String get accountsProviderEasypaisa;

  /// No description provided for @accountsProviderJazzcash.
  ///
  /// In en, this message translates to:
  /// **'JazzCash'**
  String get accountsProviderJazzcash;

  /// No description provided for @accountsProviderManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get accountsProviderManual;

  /// No description provided for @accountsMockOAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'{providerName} secure preview'**
  String accountsMockOAuthTitle(String providerName);

  /// No description provided for @accountsMockOAuthBody.
  ///
  /// In en, this message translates to:
  /// **'This screen simulates a read-only provider connection. No credentials are collected in this build.'**
  String get accountsMockOAuthBody;

  /// No description provided for @accountsConnectContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue preview'**
  String get accountsConnectContinue;

  /// No description provided for @accountsConnectSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Account connected'**
  String get accountsConnectSuccessTitle;

  /// No description provided for @accountsConnectSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'{accountName} is now available in the mock account list.'**
  String accountsConnectSuccessBody(String accountName);

  /// No description provided for @accountsViewAccounts.
  ///
  /// In en, this message translates to:
  /// **'View accounts'**
  String get accountsViewAccounts;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get profileTheme;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogout;

  /// No description provided for @profileDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get profileDelete;

  /// No description provided for @remittanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Send money home'**
  String get remittanceTitle;

  /// No description provided for @remittanceBody.
  ///
  /// In en, this message translates to:
  /// **'Phase 3 will orchestrate remittance through licensed partners. This build has no money movement.'**
  String get remittanceBody;

  /// No description provided for @remittanceCta.
  ///
  /// In en, this message translates to:
  /// **'Join waitlist'**
  String get remittanceCta;

  /// No description provided for @emptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get emptyTitle;

  /// No description provided for @emptyBody.
  ///
  /// In en, this message translates to:
  /// **'Seeded mock data will appear as each feature becomes active.'**
  String get emptyBody;

  /// No description provided for @sampleDesignLabel.
  ///
  /// In en, this message translates to:
  /// **'Sample design'**
  String get sampleDesignLabel;

  /// No description provided for @sampleDashboardAmount.
  ///
  /// In en, this message translates to:
  /// **'CAD 4,280'**
  String get sampleDashboardAmount;

  /// No description provided for @sampleBudgetAmount.
  ///
  /// In en, this message translates to:
  /// **'CAD 1,840 left'**
  String get sampleBudgetAmount;

  /// No description provided for @sampleGoalName.
  ///
  /// In en, this message translates to:
  /// **'Trip to Pakistan'**
  String get sampleGoalName;

  /// No description provided for @sampleOnTrack.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get sampleOnTrack;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
