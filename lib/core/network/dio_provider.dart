import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/network/auth_interceptor.dart';
import 'package:felo/core/network/retry_interceptor.dart';
import 'package:felo/core/storage/secure_storage_service.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.felo.invalid/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  dio.interceptors.add(AuthInterceptor(ref.watch(secureStorageServiceProvider)));
  dio.interceptors.add(RetryInterceptor(dio));
  return dio;
}
