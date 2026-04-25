import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'package:felo/core/network/dio_provider.dart';
import 'package:felo/features/transactions/domain/spending_insights.dart';

part 'felo_api_client.g.dart';

@riverpod
FeloApiClient feloApiClient(FeloApiClientRef ref) {
  return FeloApiClient(ref.watch(dioProvider));
}

/// Typed Retrofit client for the Felo backend (NestJS at FeloEnv.apiUrl).
@RestApi()
abstract class FeloApiClient {
  factory FeloApiClient(Dio dio, {String? baseUrl}) = _FeloApiClient;

  // -------- Health -------------------------------------------------
  @GET('/health')
  Future<Object?> health();

  // -------- Insights -----------------------------------------------
  @GET('/v1/insights/spending')
  Future<SpendingInsights> getSpendingInsights(@Query('period') String period);
}
