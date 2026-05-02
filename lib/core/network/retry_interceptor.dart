import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';

/// Retries idempotent requests on transient errors with full jitter.
///
/// Hardening rules (vs the prior implementation):
///   * Only retries idempotent verbs (GET, HEAD, OPTIONS). POST/PUT/PATCH/
///     DELETE are NEVER retried automatically — duplicate calls would
///     produce duplicate remittance entries and ledger writes.
///   * Full-jitter backoff: `random(0, 250 * 2^n)` ms, never a fixed schedule.
///   * Honours the `Retry-After` header (in seconds) when present.
///   * Caps at 2 retries.
class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._dio);

  final Dio _dio;
  static const _idempotentMethods = {'GET', 'HEAD', 'OPTIONS'};
  static const _maxRetries = 2;
  static final _rand = Random();

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final method = (err.requestOptions.method).toUpperCase();
    final statusCode = err.response?.statusCode ?? 0;
    final retryCount = (err.requestOptions.extra['retryCount'] as int?) ?? 0;
    final transient = statusCode == 408 || statusCode == 429 || statusCode >= 500;

    if (!_idempotentMethods.contains(method) ||
        !transient ||
        retryCount >= _maxRetries) {
      handler.next(err);
      return;
    }

    final retryAfterHeader = err.response?.headers.value('retry-after');
    final retryAfterMs = int.tryParse(retryAfterHeader ?? '');
    final backoffMs = retryAfterMs != null
        ? retryAfterMs * 1000
        : _rand.nextInt(250 * (1 << retryCount));
    await Future<void>.delayed(Duration(milliseconds: backoffMs.clamp(0, 5000)));

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
