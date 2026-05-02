import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:felo/core/network/retry_interceptor.dart';

class _MockDio extends Mock implements Dio {}

class _MockHandler extends Mock implements ErrorInterceptorHandler {}

class _FakeRequestOptions extends Fake implements RequestOptions {}

DioException _err(String method, int status) {
  final options = RequestOptions(path: '/x', method: method);
  return DioException(
    requestOptions: options,
    response: Response<dynamic>(requestOptions: options, statusCode: status),
    type: DioExceptionType.badResponse,
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeRequestOptions());
    registerFallbackValue(
      DioException(requestOptions: RequestOptions(path: '/x'), type: DioExceptionType.unknown),
    );
    registerFallbackValue(Response<dynamic>(requestOptions: RequestOptions(path: '/x')));
  });

  test('does NOT retry POST on 502 — calls handler.next, never dio.fetch', () async {
    final dio = _MockDio();
    final handler = _MockHandler();
    final interceptor = RetryInterceptor(dio);

    await interceptor.onError(_err('POST', 502), handler);

    verify(() => handler.next(any())).called(1);
    verifyNever(() => dio.fetch<Object?>(any()));
  });

  test('retries GET on 502 once and resolves on success', () async {
    final dio = _MockDio();
    final handler = _MockHandler();
    when(() => dio.fetch<Object?>(any())).thenAnswer(
      (invocation) async => Response<Object?>(
        requestOptions: invocation.positionalArguments.first as RequestOptions,
        statusCode: 200,
        data: 'ok',
      ),
    );
    final interceptor = RetryInterceptor(dio);

    await interceptor.onError(_err('GET', 502), handler);

    verify(() => dio.fetch<Object?>(any())).called(1);
    verify(() => handler.resolve(any())).called(1);
    verifyNever(() => handler.next(any()));
  });

  test('does NOT retry GET on 404 (non-transient)', () async {
    final dio = _MockDio();
    final handler = _MockHandler();
    final interceptor = RetryInterceptor(dio);

    await interceptor.onError(_err('GET', 404), handler);

    verify(() => handler.next(any())).called(1);
    verifyNever(() => dio.fetch<Object?>(any()));
  });

  test('caps retries at 2 even when fetch keeps failing', () async {
    final dio = _MockDio();
    final handler = _MockHandler();
    when(() => dio.fetch<Object?>(any())).thenAnswer(
      (invocation) async => throw DioException(
        requestOptions: invocation.positionalArguments.first as RequestOptions,
        response: Response<Object?>(
          requestOptions: invocation.positionalArguments.first as RequestOptions,
          statusCode: 502,
        ),
        type: DioExceptionType.badResponse,
      ),
    );
    final interceptor = RetryInterceptor(dio);
    final opts = _err('GET', 502);
    opts.requestOptions.extra['retryCount'] = 2;

    await interceptor.onError(opts, handler);

    // Already at the cap, so no further fetch.
    verifyNever(() => dio.fetch<Object?>(any()));
    verify(() => handler.next(any())).called(1);
  });
}
