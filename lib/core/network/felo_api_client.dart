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
  Future<void> health();

  // -------- Auth ---------------------------------------------------
  @GET('/auth/me')
  Future<void> authMe();

  // -------- Profiles -----------------------------------------------
  @GET('/profiles/me')
  Future<void> getMyProfile();

  @PATCH('/profiles/me')
  Future<void> updateMyProfile(@Body() Map<String, dynamic> body);

  // -------- Accounts -----------------------------------------------
  @GET('/accounts')
  Future<void> listAccounts();

  @POST('/accounts')
  Future<void> createAccount(@Body() Map<String, dynamic> body);

  @PATCH('/accounts/{id}')
  Future<void> updateAccount(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/accounts/{id}')
  Future<void> archiveAccount(@Path('id') String id);

  // -------- Budgets ------------------------------------------------
  @GET('/budgets')
  Future<void> listBudgets();

  @GET('/budgets/{id}')
  Future<void> getBudget(@Path('id') String id);

  @POST('/budgets')
  Future<void> createBudget(@Body() Map<String, dynamic> body);

  @PATCH('/budgets/{id}')
  Future<void> updateBudget(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/budgets/{id}')
  Future<void> archiveBudget(@Path('id') String id);

  // -------- Goals --------------------------------------------------
  @GET('/goals')
  Future<void> listGoals();

  @GET('/goals/{id}')
  Future<void> getGoal(@Path('id') String id);

  @POST('/goals')
  Future<void> createGoal(@Body() Map<String, dynamic> body);

  @PATCH('/goals/{id}')
  Future<void> updateGoal(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @POST('/goals/{id}/contributions')
  Future<void> contributeToGoal(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  // -------- Transactions -------------------------------------------
  @GET('/transactions')
  Future<void> listTransactions({
    @Query('cursor') String? cursor,
    @Query('limit') int? limit,
    @Query('category') String? category,
  });

  @GET('/transactions/sync')
  Future<void> syncTransactions(@Query('since') String since);

  @POST('/transactions')
  Future<void> createTransaction(@Body() Map<String, dynamic> body);

  // -------- Felo scores --------------------------------------------
  @GET('/felo-scores/latest')
  Future<void> latestFeloScore();

  // -------- Recurring bills ----------------------------------------
  @GET('/recurring-bills')
  Future<void> listRecurringBills();

  @POST('/recurring-bills')
  Future<void> createRecurringBill(@Body() Map<String, dynamic> body);

  // -------- Coach --------------------------------------------------
  // NOTE: dynamic return — retrofit_generator 9.7 produces broken
  // codegen for `Map<String, dynamic>` return types. The coach
  // controllers cast at the call site.
  @GET('/coach/conversations')
  Future<dynamic> listCoachConversations();

  @POST('/coach/ask')
  Future<dynamic> askCoach(@Body() Map<String, dynamic> body);
}
