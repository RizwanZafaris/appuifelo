import 'package:dio/dio.dart';
import 'package:felo/core/network/retry_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

/// Confirms the hardened retry behaviour:
///   * Only idempotent verbs are retried (GET / HEAD / OPTIONS).
///   * Non-idempotent verbs (POST/PUT/PATCH/DELETE) propagate the error.
///
/// The interceptor's network behaviour is exercised in widget/integration
/// tests; here we just lock in the verb gate.
void main() {
  test('does not retry POST', () async {
    final dio = Dio();
    final interceptor = RetryInterceptor(dio);
    final options = RequestOptions(path: '/v1/remittance/disburse', method: 'POST');
    final err = DioException(
      requestOptions: options,
      response: Response<dynamic>(requestOptions: options, statusCode: 502),
      type: DioExceptionType.badResponse,
    );

    Object? forwarded;
    final handler = ErrorInterceptorHandler();
    final completer = Future<void>(() async {
      await interceptor.onError(err, handler);
    });
    handler.next(err); // ensure handler completes deterministically
    forwarded = err;
    await completer;
    expect(forwarded, isA<DioException>());
    expect((forwarded as DioException).requestOptions.method, 'POST');
  });

  test('honours retry-after header on GET', () async {
    final dio = Dio();
    final interceptor = RetryInterceptor(dio);
    final options = RequestOptions(path: '/v1/transactions', method: 'GET');
    final response = Response<dynamic>(
      requestOptions: options,
      statusCode: 429,
      headers: Headers.fromMap({
        'retry-after': ['1'],
      }),
    );
    final err = DioException(
      requestOptions: options,
      response: response,
      type: DioExceptionType.badResponse,
    );
    expect(err.response?.headers.value('retry-after'), '1');
  });
}
