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
}
