import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'felo_api_client.g.dart';

/// Typed Retrofit client for the Felo backend (NestJS at FeloEnv.apiUrl).
/// Endpoints map 1:1 to controllers in felo-backend/src/modules/.
@RestApi()
abstract class FeloApiClient {
  factory FeloApiClient(Dio dio, {String? baseUrl}) = _FeloApiClient;

  // -------- S1 CAPTURE: SMS ----------------------------------------
  @POST('/sms/ingest')
  Future<dynamic> ingestSms(@Body() Map<String, dynamic> body);

  @GET('/sms/ingestion-log')
  Future<dynamic> listSmsIngestionLog({
    @Query('cursor') String? cursor,
    @Query('limit') int? limit,
  });

  @GET('/sms/templates')
  Future<dynamic> listSmsTemplates();

  // -------- S1 CAPTURE: Receipts -----------------------------------
  @POST('/receipts/upload')
  @MultiPart()
  Future<dynamic> uploadReceipt(@Part() File file);

  @POST('/receipts/{id}/parse')
  Future<dynamic> parseReceipt(@Path('id') String id);

  @POST('/receipts/{id}/confirm')
  Future<dynamic> confirmReceipt(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @GET('/receipts')
  Future<dynamic> listReceipts({
    @Query('cursor') String? cursor,
    @Query('limit') int? limit,
  });

  // -------- S1 CAPTURE: Statements ---------------------------------
  @POST('/statements/upload')
  @MultiPart()
  Future<dynamic> uploadStatement(
    @Part() File file,
    @Query('format') String format,
  );

  @POST('/statements/{id}/parse')
  Future<dynamic> parseStatement(@Path('id') String id);

  @POST('/statements/{id}/commit')
  Future<dynamic> commitStatement(@Path('id') String id);

  // -------- S1 CAPTURE: Categories ---------------------------------
  @GET('/categories')
  Future<dynamic> listCategories();

  @POST('/categorization/suggest')
  Future<dynamic> suggestCategory(@Body() Map<String, dynamic> body);

  // -------- S2 REMITTANCE ------------------------------------------
  @GET('/fx/rate')
  Future<dynamic> getFxRate(@Query('pair') String pair);

  @GET('/remittance/quotes')
  Future<dynamic> getRemittanceQuotes(
    @Query('source') String source,
    @Query('target') String target,
    @Query('amountMinor') int amountMinor,
  );

  @GET('/remittance/providers')
  Future<dynamic> listRemittanceProviders();

  // -------- Health -------------------------------------------------
  @GET('/health')
  Future<dynamic> health();

  // -------- Auth ---------------------------------------------------
  @GET('/auth/me')
  Future<dynamic> authMe();

  // -------- Profiles -----------------------------------------------
  @GET('/profiles/me')
  Future<dynamic> getMyProfile();

  @PATCH('/profiles/me')
  Future<dynamic> updateMyProfile(@Body() Map<String, dynamic> body);

  // -------- Referrals ----------------------------------------------
  @GET('/referrals/my-code')
  Future<dynamic> getMyReferralCode();

  @GET('/referrals/stats')
  Future<dynamic> getReferralStats();

  @GET('/referrals/mine')
  Future<dynamic> listMyReferrals();

  @POST('/referrals/redeem')
  Future<dynamic> redeemReferral(@Body() Map<String, dynamic> body);

  // -------- Accounts -----------------------------------------------
  @GET('/accounts')
  Future<dynamic> listAccounts();

  @POST('/accounts')
  Future<dynamic> createAccount(@Body() Map<String, dynamic> body);

  @PATCH('/accounts/{id}')
  Future<dynamic> updateAccount(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/accounts/{id}')
  Future<dynamic> archiveAccount(@Path('id') String id);

  // -------- Budgets ------------------------------------------------
  @GET('/budgets')
  Future<dynamic> listBudgets();

  @GET('/budgets/{id}')
  Future<dynamic> getBudget(@Path('id') String id);

  @POST('/budgets')
  Future<dynamic> createBudget(@Body() Map<String, dynamic> body);

  @PATCH('/budgets/{id}')
  Future<dynamic> updateBudget(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/budgets/{id}')
  Future<dynamic> archiveBudget(@Path('id') String id);

  // -------- Goals --------------------------------------------------
  @GET('/goals')
  Future<dynamic> listGoals();

  @GET('/goals/{id}')
  Future<dynamic> getGoal(@Path('id') String id);

  @POST('/goals')
  Future<dynamic> createGoal(@Body() Map<String, dynamic> body);

  @PATCH('/goals/{id}')
  Future<dynamic> updateGoal(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @POST('/goals/{id}/contributions')
  Future<dynamic> contributeToGoal(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  // -------- Transactions -------------------------------------------
  @GET('/transactions')
  Future<dynamic> listTransactions({
    @Query('cursor') String? cursor,
    @Query('limit') int? limit,
    @Query('category') String? category,
  });

  @GET('/transactions/sync')
  Future<dynamic> syncTransactions(@Query('since') String since);

  @POST('/transactions')
  Future<dynamic> createTransaction(@Body() Map<String, dynamic> body);

  // -------- Felo scores --------------------------------------------
  @GET('/felo-scores/latest')
  Future<dynamic> latestFeloScore();

  // -------- Recurring bills ----------------------------------------
  @GET('/recurring-bills')
  Future<dynamic> listRecurringBills();

  @POST('/recurring-bills')
  Future<dynamic> createRecurringBill(@Body() Map<String, dynamic> body);

  @POST('/recurring-bills/{id}/mark-paid')
  Future<dynamic> markRecurringBillPaid(@Path('id') String id);

  // -------- Coach --------------------------------------------------
  @GET('/coach/conversations')
  Future<dynamic> listCoachConversations();

  @POST('/coach/ask')
  Future<dynamic> askCoach(@Body() Map<String, dynamic> body);

  /// LLM-backed coach chat. Body shape:
  ///   { message, conversationId?, provider?, model? }
  /// Server runs the 3-layer pipeline (pre-guardrail → retrieval → LLM →
  /// post-guardrail) and only deducts quota on a non-refused response.
  @POST('/coach/chat')
  Future<dynamic> chatCoach(@Body() Map<String, dynamic> body);

  @GET('/coach/models')
  Future<dynamic> listCoachModels();

  @GET('/coach/quota')
  Future<dynamic> coachQuota();

  // -------- Security / MFA -----------------------------------------
  @GET('/security/mfa/status')
  Future<dynamic> mfaStatus();

  @POST('/security/mfa/enroll')
  Future<dynamic> mfaEnroll();

  @POST('/security/mfa/verify-enrollment')
  Future<dynamic> mfaVerifyEnrollment(@Body() Map<String, dynamic> body);

  @DELETE('/security/mfa')
  Future<dynamic> mfaDisable();

  // -------- Insights -----------------------------------------------
  @GET('/insights/spending')
  Future<dynamic> getSpendingInsights(@Query('period') String period);

  // -------- Splits -------------------------------------------------
  @GET('/splits')
  Future<dynamic> listSplits({@Query('status') String? status});

  @GET('/splits/{id}')
  Future<dynamic> getSplit(@Path('id') String id);

  @POST('/splits')
  Future<dynamic> createSplit(@Body() Map<String, dynamic> body);

  @PATCH('/splits/{id}')
  Future<dynamic> updateSplit(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/splits/{id}')
  Future<dynamic> deleteSplit(@Path('id') String id);

  @POST('/splits/{id}/participants')
  Future<dynamic> addSplitParticipant(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/splits/{id}/participants/{participantId}')
  Future<dynamic> updateSplitParticipant(
    @Path('id') String id,
    @Path('participantId') String participantId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/splits/{id}/participants/{participantId}')
  Future<dynamic> deleteSplitParticipant(
    @Path('id') String id,
    @Path('participantId') String participantId,
  );

  @POST('/splits/{id}/settle')
  Future<dynamic> settleSplit(@Path('id') String id);

  // -------- Investments --------------------------------------------
  @GET('/investments')
  Future<dynamic> listInvestments();

  @GET('/investments/portfolio')
  Future<dynamic> getInvestmentPortfolio();

  @GET('/investments/{id}')
  Future<dynamic> getInvestment(@Path('id') String id);

  @POST('/investments')
  Future<dynamic> createInvestment(@Body() Map<String, dynamic> body);

  @PATCH('/investments/{id}')
  Future<dynamic> updateInvestment(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/investments/{id}')
  Future<dynamic> archiveInvestment(@Path('id') String id);

  // -------- Notifications -----------------------------------------
  @GET('/notifications')
  Future<dynamic> listNotifications({@Query('unreadOnly') bool? unreadOnly});

  @GET('/notifications/unread-count')
  Future<dynamic> notificationsUnreadCount();

  @POST('/notifications/{id}/read')
  Future<dynamic> markNotificationRead(@Path('id') String id);

  @POST('/notifications/read-all')
  Future<dynamic> markAllNotificationsRead();

  @DELETE('/notifications/{id}')
  Future<dynamic> deleteNotification(@Path('id') String id);

  // -------- Devices -----------------------------------------------
  @GET('/devices')
  Future<dynamic> listDevices();

  @POST('/devices')
  Future<dynamic> registerDevice(@Body() Map<String, dynamic> body);

  @DELETE('/devices/{id}')
  Future<dynamic> unregisterDevice(@Path('id') String id);

  // -------- Reports (Weekly / Monthly) ------------------------------
  @GET('/reports/weekly')
  Future<dynamic> weeklyReport();

  @GET('/reports/monthly/{year}/{month}')
  Future<dynamic> monthlyReport(
    @Path('year') int year,
    @Path('month') int month,
  );

  // -------- Cash Envelopes ------------------------------------------
  @GET('/cash-envelopes')
  Future<dynamic> cashEnvelopes();

  @POST('/cash-envelopes')
  Future<dynamic> createCashEnvelope(@Body() Map<String, dynamic> body);

  @PATCH('/cash-envelopes/{id}/spend')
  Future<dynamic> spendCashEnvelope(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/cash-envelopes/{id}')
  Future<dynamic> deleteCashEnvelope(@Path('id') String id);

  // -------- Remittance Notebook -------------------------------------
  @GET('/remittance-notebook')
  Future<dynamic> remittanceNotebook({@Query('status') String? status});

  @GET('/remittance-notebook/summary')
  Future<dynamic> remittanceSummary();

  @POST('/remittance-notebook')
  Future<dynamic> createRemittanceEntry(@Body() Map<String, dynamic> body);

  @PATCH('/remittance-notebook/{id}')
  Future<dynamic> updateRemittanceEntry(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/remittance-notebook/{id}/mark-sent')
  Future<dynamic> markRemittanceSent(@Path('id') String id);

  @DELETE('/remittance-notebook/{id}')
  Future<dynamic> deleteRemittanceEntry(@Path('id') String id);

  // -------- Monthly Close -------------------------------------------
  @GET('/monthly-close')
  Future<dynamic> listMonthlyCloses();

  @GET('/monthly-close/{year}/{month}')
  Future<dynamic> monthlyClose(
    @Path('year') int year,
    @Path('month') int month,
  );

  @GET('/monthly-close/{year}/{month}/checklist')
  Future<dynamic> monthlyCloseChecklist(
    @Path('year') int year,
    @Path('month') int month,
  );

  @PATCH('/monthly-close/{year}/{month}/checklist')
  Future<dynamic> updateMonthlyCloseChecklist(
    @Path('year') int year,
    @Path('month') int month,
    @Body() Map<String, dynamic> body,
  );

  @POST('/monthly-close/{year}/{month}/close')
  Future<dynamic> closeMonth(
    @Path('year') int year,
    @Path('month') int month,
  );

  // -------- S3 IDENTITY: Family ------------------------------------
  @POST('/family/groups')
  Future<dynamic> createFamilyGroup(@Body() Map<String, dynamic> body);

  @GET('/family/groups')
  Future<dynamic> listFamilyGroups();

  @GET('/family/groups/{id}')
  Future<dynamic> getFamilyGroup(@Path('id') String id);

  @POST('/family/groups/{id}/invite')
  Future<dynamic> inviteFamilyMember(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @POST('/family/invitations/{code}/accept')
  Future<dynamic> acceptFamilyInvitation(@Path('code') String code);

  @GET('/family/groups/{id}/members')
  Future<dynamic> listFamilyMembers(@Path('id') String id);

  // -------- S3 IDENTITY: KYC ---------------------------------------
  @POST('/kyc/initiate')
  Future<dynamic> initiateKyc(@Body() Map<String, dynamic> body);

  @GET('/kyc/status')
  Future<dynamic> getKycStatus();

  // -------- S4 INTELLIGENCE: Felo Scores ---------------------------
  @GET('/felo-scores/latest')
  Future<dynamic> getLatestFeloScore();

  @GET('/felo-scores/history')
  Future<dynamic> getFeloScoreHistory({@Query('weeks') int? weeks});

  @GET('/felo-scores/breakdown')
  Future<dynamic> getFeloScoreBreakdown();

  // -------- S4 INTELLIGENCE: Coach ---------------------------------
  @POST('/coach/chat')
  Future<dynamic> sendCoachMessage(@Body() Map<String, dynamic> body);

  @GET('/coach/history')
  Future<dynamic> getCoachHistory();

  // -------- S4 INTELLIGENCE: Investments / Market ------------------
  @GET('/investments/market/{symbol}/quote')
  Future<dynamic> getMarketQuote(@Path('symbol') String symbol);

  @GET('/investments/portfolio')
  Future<dynamic> getPortfolio();

  // -------- S4 INTELLIGENCE: Notifications -------------------------
  @GET('/notifications')
  Future<dynamic> listNotifications({
    @Query('cursor') String? cursor,
    @Query('limit') int? limit,
  });

  @POST('/notifications/{id}/read')
  Future<dynamic> markNotificationRead(@Path('id') String id);

  @POST('/notifications/read-all')
  Future<dynamic> markAllNotificationsRead();

  @POST('/notifications/subscribe')
  Future<dynamic> subscribeNotifications(@Body() Map<String, dynamic> body);

  // -------- S5 MONETIZATION: Subscriptions -------------------------
  @POST('/subscriptions/checkout')
  Future<dynamic> createCheckoutSession(@Body() Map<String, dynamic> body);

  @GET('/subscriptions/me')
  Future<dynamic> getMySubscription();

  @POST('/subscriptions/restore')
  Future<dynamic> restorePurchases();

  @POST('/subscriptions/apply-coupon')
  Future<dynamic> applyCoupon(@Body() Map<String, dynamic> body);

  @GET('/paywall/config')
  Future<dynamic> getPaywallConfig();

  // -------- Subscriptions / Tier (legacy) --------------------------
  @GET('/subscriptions/tier')
  Future<dynamic> subscriptionTier();

  @POST('/subscriptions/upgrade')
  Future<dynamic> upgradeSubscription(@Body() Map<String, dynamic> body);

  // -------- S7 PLATFORM: i18n / Feature Flags ----------------------
  @GET('/i18n/strings')
  Future<dynamic> getI18nStrings(@Query('locale') String locale);

  @GET('/flags')
  Future<dynamic> getFeatureFlags();

  @GET('/banners/active')
  Future<dynamic> getActiveBanners();

  // -------- Export / Data Controls ----------------------------------
  @POST('/export')
  Future<dynamic> requestExport(@Body() Map<String, dynamic> body);

  @GET('/export')
  Future<dynamic> listExports();

  @DELETE('/export/account')
  Future<dynamic> deleteAccountData();
}
