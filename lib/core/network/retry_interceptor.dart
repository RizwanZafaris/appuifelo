import 'dart:async';

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._dio);

  final Dio _dio;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode ?? 0;
    final shouldRetry = statusCode == 408 || statusCode == 429 || statusCode >= 500;
    final retryCount = (err.requestOptions.extra['retryCount'] as int?) ?? 0;

    if (!shouldRetry || retryCount >= 2) {
      handler.next(err);
      return;
    }

    await Future<void>.delayed(Duration(milliseconds: 250 * (retryCount + 1)));
    final requestOptions = err.requestOptions;
    requestOptions.extra['retryCount'] = retryCount + 1;
    try {
      final response = await _dio.fetch<Object?>(requestOptions);
      handler.resolve(response);
    } on DioException catch (error) {
      handler.next(error);
    }
  }
}
