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
  Future<Map<String, dynamic>> health();

  // -------- Auth ---------------------------------------------------
  @GET('/auth/me')
  Future<Map<String, dynamic>> authMe();

  // -------- Profiles -----------------------------------------------
  @GET('/profiles/me')
  Future<Map<String, dynamic>> getMyProfile();

  @PATCH('/profiles/me')
  Future<Map<String, dynamic>> updateMyProfile(
    @Body() Map<String, dynamic> body,
  );

  // -------- Accounts -----------------------------------------------
  @GET('/accounts')
  Future<List<Map<String, dynamic>>> listAccounts();

  @POST('/accounts')
  Future<Map<String, dynamic>> createAccount(@Body() Map<String, dynamic> body);

  @PATCH('/accounts/{id}')
  Future<Map<String, dynamic>> updateAccount(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/accounts/{id}')
  Future<Map<String, dynamic>> archiveAccount(@Path('id') String id);

  // -------- Budgets ------------------------------------------------
  @GET('/budgets')
  Future<List<Map<String, dynamic>>> listBudgets();

  @GET('/budgets/{id}')
  Future<Map<String, dynamic>> getBudget(@Path('id') String id);

  @POST('/budgets')
  Future<Map<String, dynamic>> createBudget(@Body() Map<String, dynamic> body);

  @PATCH('/budgets/{id}')
  Future<Map<String, dynamic>> updateBudget(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/budgets/{id}')
  Future<Map<String, dynamic>> archiveBudget(@Path('id') String id);

  // -------- Goals --------------------------------------------------
  @GET('/goals')
  Future<List<Map<String, dynamic>>> listGoals();

  @GET('/goals/{id}')
  Future<Map<String, dynamic>> getGoal(@Path('id') String id);

  @POST('/goals')
  Future<Map<String, dynamic>> createGoal(@Body() Map<String, dynamic> body);

  @PATCH('/goals/{id}')
  Future<Map<String, dynamic>> updateGoal(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @POST('/goals/{id}/contributions')
  Future<Map<String, dynamic>> contributeToGoal(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  // -------- Transactions -------------------------------------------
  @GET('/transactions')
  Future<List<Map<String, dynamic>>> listTransactions({
    @Query('cursor') String? cursor,
    @Query('limit') int? limit,
    @Query('category') String? category,
  });

  @GET('/transactions/sync')
  Future<List<Map<String, dynamic>>> syncTransactions(
    @Query('since') String since,
  );

  @POST('/transactions')
  Future<Map<String, dynamic>> createTransaction(
    @Body() Map<String, dynamic> body,
  );

  // -------- Coach --------------------------------------------------
  @GET('/coach/conversations')
  Future<List<Map<String, dynamic>>> listCoachConversations();

  @POST('/coach/ask')
  Future<Map<String, dynamic>> askCoach(@Body() Map<String, dynamic> body);

  // -------- Felo scores --------------------------------------------
  @GET('/felo-scores/latest')
  Future<Map<String, dynamic>?> latestFeloScore();

  // -------- Recurring bills ----------------------------------------
  @GET('/recurring-bills')
  Future<List<Map<String, dynamic>>> listRecurringBills();

  @POST('/recurring-bills')
  Future<Map<String, dynamic>> createRecurringBill(
    @Body() Map<String, dynamic> body,
  );
}
