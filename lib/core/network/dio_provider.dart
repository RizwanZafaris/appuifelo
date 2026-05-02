import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/cert_pinning.dart';
import 'package:felo/core/network/retry_interceptor.dart';
import 'package:felo/core/network/supabase_auth_interceptor.dart';
import 'package:felo/core/network/trace_interceptor.dart';
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
      sendTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
        'X-App-Platform': 'flutter',
      },
    ),
  );

  // Order matters:
  //   1. CertPinning configures the underlying HttpClient (TLS pinning).
  //   2. TraceInterceptor mints / forwards X-Request-ID for end-to-end tracing.
  //   3. SupabaseAuthInterceptor attaches Bearer token + handles refresh.
  //   4. RetryInterceptor retries idempotent verbs only with full jitter.
  CertPinning.apply(dio);
  dio.interceptors.add(TraceInterceptor(uuid: const Uuid()));
  dio.interceptors.add(SupabaseAuthInterceptor(supabase));
  dio.interceptors.add(RetryInterceptor(dio));
  return dio;
}
