import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/retry_interceptor.dart';
import 'package:felo/core/network/supabase_auth_interceptor.dart';
import 'package:felo/core/supabase/supabase_provider.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: FeloEnv.apiUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(SupabaseAuthInterceptor(supabase));
  dio.interceptors.add(RetryInterceptor(dio));
  return dio;
}

@riverpod
FeloApiClient feloApiClient(FeloApiClientRef ref) {
  return FeloApiClient(ref.watch(dioProvider));
}
