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

  /// No description provided for @navDo.
  ///
  /// In en, this message translates to:
  /// **'Do'**
  String get navDo;

  /// No description provided for @navGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get navGoals;

  /// No description provided for @complianceFooter.
  ///
  /// In en, this message translates to:
  /// **'Registration pending · MSB application in progress.'**
  String get complianceFooter;

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

  /// No description provided for @doHubTitle.
  ///
  /// In en, this message translates to:
  /// **'Do'**
  String get doHubTitle;

  /// No description provided for @doHubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Everything you can act on, grouped into simple aisles.'**
  String get doHubSubtitle;

  /// No description provided for @doHubSendPay.
  ///
  /// In en, this message translates to:
  /// **'Send & Pay'**
  String get doHubSendPay;

  /// No description provided for @doHubSendPayBody.
  ///
  /// In en, this message translates to:
  /// **'Remittance, bills, and split payments.'**
  String get doHubSendPayBody;

  /// No description provided for @doHubSaveTrack.
  ///
  /// In en, this message translates to:
  /// **'Save & Track'**
  String get doHubSaveTrack;

  /// No description provided for @doHubSaveTrackBody.
  ///
  /// In en, this message translates to:
  /// **'Goals, round-ups, and investment tracking.'**
  String get doHubSaveTrackBody;

  /// No description provided for @doHubSpendSmart.
  ///
  /// In en, this message translates to:
  /// **'Spend Smart'**
  String get doHubSpendSmart;

  /// No description provided for @doHubSpendSmartBody.
  ///
  /// In en, this message translates to:
  /// **'Budgets, subscriptions, and insights.'**
  String get doHubSpendSmartBody;

  /// No description provided for @doHubCardsAccounts.
  ///
  /// In en, this message translates to:
  /// **'Cards & Accounts'**
  String get doHubCardsAccounts;

  /// No description provided for @doHubCardsAccountsBody.
  ///
  /// In en, this message translates to:
  /// **'Linked banks, cards, and account controls.'**
  String get doHubCardsAccountsBody;

  /// No description provided for @doHubMoreHelp.
  ///
  /// In en, this message translates to:
  /// **'More & Help'**
  String get doHubMoreHelp;

  /// No description provided for @doHubMoreHelpBody.
  ///
  /// In en, this message translates to:
  /// **'Support, referrals, and Felo Plus.'**
  String get doHubMoreHelpBody;

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

  /// No description provided for @splitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Splits'**
  String get splitsTitle;

  /// No description provided for @splitsDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Split detail'**
  String get splitsDetailTitle;

  /// No description provided for @splitsNewSplit.
  ///
  /// In en, this message translates to:
  /// **'New split'**
  String get splitsNewSplit;

  /// No description provided for @splitsActiveTab.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get splitsActiveTab;

  /// No description provided for @splitsSettledTab.
  ///
  /// In en, this message translates to:
  /// **'Settled'**
  String get splitsSettledTab;

  /// No description provided for @splitsEmptyActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'No active splits'**
  String get splitsEmptyActiveTitle;

  /// No description provided for @splitsEmptyActiveBody.
  ///
  /// In en, this message translates to:
  /// **'Create a split to track who has paid without chasing in chat.'**
  String get splitsEmptyActiveBody;

  /// No description provided for @splitsEmptySettledTitle.
  ///
  /// In en, this message translates to:
  /// **'No settled splits'**
  String get splitsEmptySettledTitle;

  /// No description provided for @splitsEmptySettledBody.
  ///
  /// In en, this message translates to:
  /// **'Completed splits will appear here for reference.'**
  String get splitsEmptySettledBody;

  /// No description provided for @splitsPaidProgress.
  ///
  /// In en, this message translates to:
  /// **'{paid} of {total} paid'**
  String splitsPaidProgress(int paid, int total);

  /// No description provided for @splitsWizardBasics.
  ///
  /// In en, this message translates to:
  /// **'Name and currency'**
  String get splitsWizardBasics;

  /// No description provided for @splitsWizardAmount.
  ///
  /// In en, this message translates to:
  /// **'Total amount'**
  String get splitsWizardAmount;

  /// No description provided for @splitsWizardParticipants.
  ///
  /// In en, this message translates to:
  /// **'Participants'**
  String get splitsWizardParticipants;

  /// No description provided for @splitsWizardReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get splitsWizardReview;

  /// No description provided for @splitsNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Split name'**
  String get splitsNameLabel;

  /// No description provided for @splitsNameHint.
  ///
  /// In en, this message translates to:
  /// **'Rent, dinner, family gift'**
  String get splitsNameHint;

  /// No description provided for @splitsCurrencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get splitsCurrencyLabel;

  /// No description provided for @splitsAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Total amount'**
  String get splitsAmountLabel;

  /// No description provided for @splitsEqualShares.
  ///
  /// In en, this message translates to:
  /// **'Equal'**
  String get splitsEqualShares;

  /// No description provided for @splitsCustomShares.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get splitsCustomShares;

  /// No description provided for @splitsAddParticipant.
  ///
  /// In en, this message translates to:
  /// **'Add participant'**
  String get splitsAddParticipant;

  /// No description provided for @splitsRemoveParticipant.
  ///
  /// In en, this message translates to:
  /// **'Remove participant'**
  String get splitsRemoveParticipant;

  /// No description provided for @splitsParticipantNumber.
  ///
  /// In en, this message translates to:
  /// **'Participant {number}'**
  String splitsParticipantNumber(int number);

  /// No description provided for @splitsParticipantFallback.
  ///
  /// In en, this message translates to:
  /// **'Participant {number}'**
  String splitsParticipantFallback(int number);

  /// No description provided for @splitsParticipantName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get splitsParticipantName;

  /// No description provided for @splitsParticipantContact.
  ///
  /// In en, this message translates to:
  /// **'Phone or email'**
  String get splitsParticipantContact;

  /// No description provided for @splitsParticipantShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get splitsParticipantShare;

  /// No description provided for @splitsShareValidationOk.
  ///
  /// In en, this message translates to:
  /// **'Shares match the total.'**
  String get splitsShareValidationOk;

  /// No description provided for @splitsShareValidationError.
  ///
  /// In en, this message translates to:
  /// **'Shares add up to {current}, expected {expected}.'**
  String splitsShareValidationError(String current, String expected);

  /// No description provided for @splitsCreateSplit.
  ///
  /// In en, this message translates to:
  /// **'Create split'**
  String get splitsCreateSplit;

  /// No description provided for @splitsParticipantsTitle.
  ///
  /// In en, this message translates to:
  /// **'Participants'**
  String get splitsParticipantsTitle;

  /// No description provided for @splitsSettleAll.
  ///
  /// In en, this message translates to:
  /// **'Settle all'**
  String get splitsSettleAll;

  /// No description provided for @splitsNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Split not found'**
  String get splitsNotFoundTitle;

  /// No description provided for @splitsNotFoundBody.
  ///
  /// In en, this message translates to:
  /// **'This split may have been closed or removed.'**
  String get splitsNotFoundBody;

  /// No description provided for @splitsContactMissing.
  ///
  /// In en, this message translates to:
  /// **'No contact added'**
  String get splitsContactMissing;

  /// No description provided for @sendTitle.
  ///
  /// In en, this message translates to:
  /// **'Send money'**
  String get sendTitle;

  /// No description provided for @sendPickRecipientTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick recipient'**
  String get sendPickRecipientTitle;

  /// No description provided for @sendAddRecipient.
  ///
  /// In en, this message translates to:
  /// **'Add new recipient'**
  String get sendAddRecipient;

  /// No description provided for @sendRecipientNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Recipient name'**
  String get sendRecipientNameLabel;

  /// No description provided for @sendRecipientPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get sendRecipientPhoneLabel;

  /// No description provided for @sendRecipientFallback.
  ///
  /// In en, this message translates to:
  /// **'New recipient'**
  String get sendRecipientFallback;

  /// No description provided for @sendRecipientPhoneFallback.
  ///
  /// In en, this message translates to:
  /// **'+92 *** *** ****'**
  String get sendRecipientPhoneFallback;

  /// No description provided for @sendAmountTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get sendAmountTitle;

  /// No description provided for @sendNoRecipientTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a recipient first'**
  String get sendNoRecipientTitle;

  /// No description provided for @sendNoRecipientBody.
  ///
  /// In en, this message translates to:
  /// **'The preview needs a saved or newly added recipient before amount entry.'**
  String get sendNoRecipientBody;

  /// No description provided for @sendAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount in CAD'**
  String get sendAmountLabel;

  /// No description provided for @sendFxPreviewEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount to preview PKR'**
  String get sendFxPreviewEmpty;

  /// No description provided for @sendFxPreview.
  ///
  /// In en, this message translates to:
  /// **'Recipient gets about {amount}'**
  String sendFxPreview(String amount);

  /// No description provided for @sendFxRate.
  ///
  /// In en, this message translates to:
  /// **'Mock rate: 1 {sourceCurrency} = {rate} {targetCurrency}'**
  String sendFxRate(String sourceCurrency, String rate, String targetCurrency);

  /// No description provided for @sendReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review preview'**
  String get sendReviewTitle;

  /// No description provided for @sendReviewMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview not ready'**
  String get sendReviewMissingTitle;

  /// No description provided for @sendReviewMissingBody.
  ///
  /// In en, this message translates to:
  /// **'Choose a recipient and amount before reviewing.'**
  String get sendReviewMissingBody;

  /// No description provided for @sendRecipientLabel.
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get sendRecipientLabel;

  /// No description provided for @sendRecipientGetsLabel.
  ///
  /// In en, this message translates to:
  /// **'Recipient gets'**
  String get sendRecipientGetsLabel;

  /// No description provided for @sendPreviewDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This is a preview. No money is moved. Phase 3 will require licensed partners before any transfer flow exists.'**
  String get sendPreviewDisclaimer;

  /// No description provided for @sendConfirmPreview.
  ///
  /// In en, this message translates to:
  /// **'Confirm preview'**
  String get sendConfirmPreview;

  /// No description provided for @sendSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview created'**
  String get sendSuccessTitle;

  /// No description provided for @sendSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'Reference {referenceId} is for this preview only. No money was moved.'**
  String sendSuccessBody(String referenceId);

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

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get helpTitle;

  /// No description provided for @helpSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search help'**
  String get helpSearchLabel;

  /// No description provided for @helpSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Type a question or keyword'**
  String get helpSearchHint;

  /// No description provided for @helpNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results yet — try a different search.'**
  String get helpNoResults;

  /// No description provided for @helpContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get helpContactSupport;

  /// No description provided for @helpReportBug.
  ///
  /// In en, this message translates to:
  /// **'Report a bug'**
  String get helpReportBug;

  /// No description provided for @helpTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get helpTerms;

  /// No description provided for @helpPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get helpPrivacy;

  /// No description provided for @helpLicenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get helpLicenses;

  /// No description provided for @helpFaq1Q.
  ///
  /// In en, this message translates to:
  /// **'Is Felo a bank?'**
  String get helpFaq1Q;

  /// No description provided for @helpFaq1A.
  ///
  /// In en, this message translates to:
  /// **'No. Felo is a budgeting and goal companion. We never hold or move your money.'**
  String get helpFaq1A;

  /// No description provided for @helpFaq2Q.
  ///
  /// In en, this message translates to:
  /// **'How does SMS parsing work?'**
  String get helpFaq2Q;

  /// No description provided for @helpFaq2A.
  ///
  /// In en, this message translates to:
  /// **'On Android, Felo reads SMS from saved bank and wallet senders on your device. SMS bodies never leave your phone in Phase 1.'**
  String get helpFaq2A;

  /// No description provided for @helpFaq3Q.
  ///
  /// In en, this message translates to:
  /// **'Can my family see my transactions?'**
  String get helpFaq3Q;

  /// No description provided for @helpFaq3A.
  ///
  /// In en, this message translates to:
  /// **'Only if you invite them and explicitly enable shared visibility. You can revoke access at any time.'**
  String get helpFaq3A;

  /// No description provided for @helpFaq4Q.
  ///
  /// In en, this message translates to:
  /// **'How do I change language?'**
  String get helpFaq4Q;

  /// No description provided for @helpFaq4A.
  ///
  /// In en, this message translates to:
  /// **'Open Profile → Settings → Language. Felo supports English and Urdu (RTL).'**
  String get helpFaq4A;

  /// No description provided for @helpFaq5Q.
  ///
  /// In en, this message translates to:
  /// **'What happens if I delete my account?'**
  String get helpFaq5Q;

  /// No description provided for @helpFaq5A.
  ///
  /// In en, this message translates to:
  /// **'Your data is soft-deleted for 30 days, then permanently erased. You can export everything before deletion.'**
  String get helpFaq5A;

  /// No description provided for @kycTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your identity'**
  String get kycTitle;

  /// No description provided for @kycChooseIdType.
  ///
  /// In en, this message translates to:
  /// **'Choose ID type'**
  String get kycChooseIdType;

  /// No description provided for @kycIdPassport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get kycIdPassport;

  /// No description provided for @kycIdCnic.
  ///
  /// In en, this message translates to:
  /// **'Pakistani CNIC'**
  String get kycIdCnic;

  /// No description provided for @kycIdDriversLicense.
  ///
  /// In en, this message translates to:
  /// **'Driver\'s license'**
  String get kycIdDriversLicense;

  /// No description provided for @kycCaptureIdTitle.
  ///
  /// In en, this message translates to:
  /// **'Capture your ID'**
  String get kycCaptureIdTitle;

  /// No description provided for @kycCaptureFront.
  ///
  /// In en, this message translates to:
  /// **'Capture front'**
  String get kycCaptureFront;

  /// No description provided for @kycCaptureBack.
  ///
  /// In en, this message translates to:
  /// **'Capture back'**
  String get kycCaptureBack;

  /// No description provided for @kycSelfieTitle.
  ///
  /// In en, this message translates to:
  /// **'Take a selfie'**
  String get kycSelfieTitle;

  /// No description provided for @kycCaptureSelfie.
  ///
  /// In en, this message translates to:
  /// **'Capture selfie'**
  String get kycCaptureSelfie;

  /// No description provided for @kycSelfieHint.
  ///
  /// In en, this message translates to:
  /// **'Look straight at the camera in good light. Glasses off.'**
  String get kycSelfieHint;

  /// No description provided for @kycReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review and submit'**
  String get kycReviewTitle;

  /// No description provided for @kycReviewIdType.
  ///
  /// In en, this message translates to:
  /// **'ID type'**
  String get kycReviewIdType;

  /// No description provided for @kycReviewIdImages.
  ///
  /// In en, this message translates to:
  /// **'ID images'**
  String get kycReviewIdImages;

  /// No description provided for @kycReviewSelfie.
  ///
  /// In en, this message translates to:
  /// **'Selfie'**
  String get kycReviewSelfie;

  /// No description provided for @kycReviewCaptured.
  ///
  /// In en, this message translates to:
  /// **'Captured'**
  String get kycReviewCaptured;

  /// No description provided for @kycReviewMissing.
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get kycReviewMissing;

  /// No description provided for @kycReviewDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Submitting sends data to a verification partner. Phase 1 builds use a stub — no data leaves the device.'**
  String get kycReviewDisclaimer;

  /// No description provided for @kycSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get kycSubmit;

  /// No description provided for @kycSubmittedTitle.
  ///
  /// In en, this message translates to:
  /// **'Submitted for review'**
  String get kycSubmittedTitle;

  /// No description provided for @kycSubmittedBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ll notify you when verification completes. You can keep using budgeting features in the meantime.'**
  String get kycSubmittedBody;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the email tied to your Felo account. We\'ll send you a reset link.'**
  String get forgotPasswordBody;

  /// No description provided for @forgotPasswordSendCta.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get forgotPasswordSendCta;

  /// No description provided for @forgotPasswordSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox'**
  String get forgotPasswordSentTitle;

  /// No description provided for @forgotPasswordSentBody.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for that email, a reset link is on its way. The link expires in 30 minutes.'**
  String get forgotPasswordSentBody;

  /// No description provided for @emailVerifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify email'**
  String get emailVerifyTitle;

  /// No description provided for @emailVerifyHeading.
  ///
  /// In en, this message translates to:
  /// **'Confirm your email'**
  String get emailVerifyHeading;

  /// No description provided for @emailVerifyBody.
  ///
  /// In en, this message translates to:
  /// **'Tap the link in the email we just sent to finish setting up your Felo account.'**
  String get emailVerifyBody;

  /// No description provided for @emailVerifyResend.
  ///
  /// In en, this message translates to:
  /// **'Resend email'**
  String get emailVerifyResend;

  /// No description provided for @emailVerifyResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String emailVerifyResendIn(String seconds);

  /// No description provided for @mfaTitle.
  ///
  /// In en, this message translates to:
  /// **'Two-factor authentication'**
  String get mfaTitle;

  /// No description provided for @mfaBody.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code with an authenticator app, then enter the 6-digit code to confirm.'**
  String get mfaBody;

  /// No description provided for @mfaCopySecret.
  ///
  /// In en, this message translates to:
  /// **'Copy secret key'**
  String get mfaCopySecret;

  /// No description provided for @mfaSecretCopied.
  ///
  /// In en, this message translates to:
  /// **'Secret copied'**
  String get mfaSecretCopied;

  /// No description provided for @mfaCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'6-digit code'**
  String get mfaCodeLabel;

  /// No description provided for @mfaVerifyCta.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get mfaVerifyCta;

  /// No description provided for @mfaVerified.
  ///
  /// In en, this message translates to:
  /// **'Two-factor enabled'**
  String get mfaVerified;

  /// No description provided for @biometricTitle.
  ///
  /// In en, this message translates to:
  /// **'App lock'**
  String get biometricTitle;

  /// No description provided for @biometricBody.
  ///
  /// In en, this message translates to:
  /// **'Add a biometric lock so only you can open Felo.'**
  String get biometricBody;

  /// No description provided for @biometricEnable.
  ///
  /// In en, this message translates to:
  /// **'Use biometric unlock'**
  String get biometricEnable;

  /// No description provided for @biometricAutoLock.
  ///
  /// In en, this message translates to:
  /// **'Auto-lock after'**
  String get biometricAutoLock;

  /// No description provided for @biometricImmediate.
  ///
  /// In en, this message translates to:
  /// **'Immediately'**
  String get biometricImmediate;

  /// No description provided for @biometricAfter1Min.
  ///
  /// In en, this message translates to:
  /// **'1 minute of inactivity'**
  String get biometricAfter1Min;

  /// No description provided for @biometricAfter5Min.
  ///
  /// In en, this message translates to:
  /// **'5 minutes of inactivity'**
  String get biometricAfter5Min;

  /// No description provided for @biometricAfter15Min.
  ///
  /// In en, this message translates to:
  /// **'15 minutes of inactivity'**
  String get biometricAfter15Min;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageUrdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu (اردو)'**
  String get languageUrdu;

  /// No description provided for @languageHelper.
  ///
  /// In en, this message translates to:
  /// **'We localize numbers and currencies, but never translate amounts.'**
  String get languageHelper;

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeTitle;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'Match system'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @notifPrefsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification preferences'**
  String get notifPrefsTitle;

  /// No description provided for @notifPrefsBudgets.
  ///
  /// In en, this message translates to:
  /// **'Budget alerts'**
  String get notifPrefsBudgets;

  /// No description provided for @notifPrefsGoals.
  ///
  /// In en, this message translates to:
  /// **'Goal milestones'**
  String get notifPrefsGoals;

  /// No description provided for @notifPrefsFamily.
  ///
  /// In en, this message translates to:
  /// **'Family activity'**
  String get notifPrefsFamily;

  /// No description provided for @notifPrefsCoach.
  ///
  /// In en, this message translates to:
  /// **'Coach nudges'**
  String get notifPrefsCoach;

  /// No description provided for @notifPrefsSystem.
  ///
  /// In en, this message translates to:
  /// **'System & security'**
  String get notifPrefsSystem;

  /// No description provided for @notifPrefsQuietHours.
  ///
  /// In en, this message translates to:
  /// **'Quiet hours'**
  String get notifPrefsQuietHours;

  /// No description provided for @notifPrefsQuietHoursHelper.
  ///
  /// In en, this message translates to:
  /// **'Mute non-critical alerts overnight (10pm–7am).'**
  String get notifPrefsQuietHoursHelper;

  /// No description provided for @dataExportTitle.
  ///
  /// In en, this message translates to:
  /// **'Export your data'**
  String get dataExportTitle;

  /// No description provided for @dataExportBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ll prepare a downloadable archive of everything tied to your account.'**
  String get dataExportBody;

  /// No description provided for @dataExportScopeAll.
  ///
  /// In en, this message translates to:
  /// **'Everything'**
  String get dataExportScopeAll;

  /// No description provided for @dataExportScopeTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions only'**
  String get dataExportScopeTransactions;

  /// No description provided for @dataExportScopeBudgets.
  ///
  /// In en, this message translates to:
  /// **'Budgets only'**
  String get dataExportScopeBudgets;

  /// No description provided for @dataExportScopeGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals only'**
  String get dataExportScopeGoals;

  /// No description provided for @dataExportRequestCta.
  ///
  /// In en, this message translates to:
  /// **'Request export'**
  String get dataExportRequestCta;

  /// No description provided for @dataExportRequested.
  ///
  /// In en, this message translates to:
  /// **'Export requested'**
  String get dataExportRequested;

  /// No description provided for @dataExportEta.
  ///
  /// In en, this message translates to:
  /// **'We\'ll email you a link within 24 hours.'**
  String get dataExportEta;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'This is permanent after 30 days.'**
  String get deleteAccountWarningTitle;

  /// No description provided for @deleteAccountWarningBody.
  ///
  /// In en, this message translates to:
  /// **'Your data is soft-deleted immediately and fully erased after 30 days. You can cancel during the grace period by signing in.'**
  String get deleteAccountWarningBody;

  /// No description provided for @deleteAccountTypePrompt.
  ///
  /// In en, this message translates to:
  /// **'Type DELETE in capitals to confirm.'**
  String get deleteAccountTypePrompt;

  /// No description provided for @deleteAccountConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Type DELETE'**
  String get deleteAccountConfirmLabel;

  /// No description provided for @deleteAccountCta.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get deleteAccountCta;

  /// No description provided for @deleteAccountSubmittedTitle.
  ///
  /// In en, this message translates to:
  /// **'Account scheduled for deletion'**
  String get deleteAccountSubmittedTitle;

  /// No description provided for @deleteAccountSubmittedBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ve signed you out. You\'ll receive a confirmation email shortly.'**
  String get deleteAccountSubmittedBody;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Felo'**
  String get aboutTitle;

  /// No description provided for @aboutTagline.
  ///
  /// In en, this message translates to:
  /// **'A no-custody money companion for the Pakistani diaspora.'**
  String get aboutTagline;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersion;

  /// No description provided for @aboutBuild.
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get aboutBuild;

  /// No description provided for @aboutCopyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright'**
  String get aboutCopyright;

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTitle;

  /// No description provided for @categoriesAdd.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get categoriesAdd;

  /// No description provided for @recurringTitle.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurringTitle;

  /// No description provided for @recurringBody.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions and bills we\'ve spotted in your activity.'**
  String get recurringBody;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// No description provided for @insightsThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Spent this month'**
  String get insightsThisMonth;

  /// No description provided for @insightsByCategory.
  ///
  /// In en, this message translates to:
  /// **'By category'**
  String get insightsByCategory;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @searchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search Felo'**
  String get searchLabel;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Merchant, category, goal…'**
  String get searchHint;

  /// No description provided for @searchPrompt.
  ///
  /// In en, this message translates to:
  /// **'Type at least one character to search.'**
  String get searchPrompt;

  /// No description provided for @searchEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get searchEmptyTitle;

  /// No description provided for @searchEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Try a different keyword.'**
  String get searchEmptyBody;

  /// No description provided for @searchTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get searchTransactions;

  /// No description provided for @searchBudgets.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get searchBudgets;

  /// No description provided for @searchGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get searchGoals;

  /// No description provided for @networkErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Connection issue'**
  String get networkErrorTitle;

  /// No description provided for @networkErrorHeading.
  ///
  /// In en, this message translates to:
  /// **'We can\'t reach the network'**
  String get networkErrorHeading;

  /// No description provided for @networkErrorBody.
  ///
  /// In en, this message translates to:
  /// **'Felo works offline for cached data — try again to sync.'**
  String get networkErrorBody;

  /// No description provided for @networkErrorRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get networkErrorRetry;

  /// No description provided for @appLockTitle.
  ///
  /// In en, this message translates to:
  /// **'App locked'**
  String get appLockTitle;

  /// No description provided for @appLockHeading.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get appLockHeading;

  /// No description provided for @appLockPinLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN'**
  String get appLockPinLabel;

  /// No description provided for @appLockUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get appLockUnlock;

  /// No description provided for @appLockUseBiometric.
  ///
  /// In en, this message translates to:
  /// **'Use biometric'**
  String get appLockUseBiometric;

  /// No description provided for @appLockWrongPin.
  ///
  /// In en, this message translates to:
  /// **'Wrong PIN. Try again.'**
  String get appLockWrongPin;

  /// No description provided for @familyInviteTitle.
  ///
  /// In en, this message translates to:
  /// **'Family invite'**
  String get familyInviteTitle;

  /// No description provided for @familyInviteFromHeading.
  ///
  /// In en, this message translates to:
  /// **'You\'ve been invited'**
  String get familyInviteFromHeading;

  /// No description provided for @familyInviteDescription.
  ///
  /// In en, this message translates to:
  /// **'Join a family group to share visibility on selected budgets and goals.'**
  String get familyInviteDescription;

  /// No description provided for @familyInvitePermViewTxns.
  ///
  /// In en, this message translates to:
  /// **'View shared transactions'**
  String get familyInvitePermViewTxns;

  /// No description provided for @familyInvitePermViewBudgets.
  ///
  /// In en, this message translates to:
  /// **'View shared budgets'**
  String get familyInvitePermViewBudgets;

  /// No description provided for @familyInvitePermEditBudgets.
  ///
  /// In en, this message translates to:
  /// **'Edit shared budgets'**
  String get familyInvitePermEditBudgets;

  /// No description provided for @familyInviteAcceptCta.
  ///
  /// In en, this message translates to:
  /// **'Accept invite'**
  String get familyInviteAcceptCta;

  /// No description provided for @familyInviteDeclineCta.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get familyInviteDeclineCta;

  /// No description provided for @familyInviteAccepted.
  ///
  /// In en, this message translates to:
  /// **'You\'re now part of the family group.'**
  String get familyInviteAccepted;

  /// No description provided for @familyInviteTokenHint.
  ///
  /// In en, this message translates to:
  /// **'Invite token: {token}'**
  String familyInviteTokenHint(String token);
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
