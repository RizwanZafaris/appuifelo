import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'felo_api_client.g.dart';

/// Typed Retrofit client for the Felo backend (NestJS at FeloEnv.apiUrl).
/// Endpoints map 1:1 to controllers in felo-backend/src/modules/.
@RestApi()
abstract class FeloApiClient {
  factory FeloApiClient(Dio dio, {String? baseUrl}) = _FeloApiClient;

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

  // -------- Coach --------------------------------------------------
  @GET('/coach/conversations')
  Future<dynamic> listCoachConversations();

  @POST('/coach/ask')
  Future<dynamic> askCoach(@Body() Map<String, dynamic> body);

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
}
