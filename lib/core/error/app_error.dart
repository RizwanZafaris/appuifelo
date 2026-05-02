import 'package:dio/dio.dart';

/// Global error taxonomy. Every error surfaced to the UI is one of these
/// kinds, with a stable `code` for analytics + i18n + Crashlytics tags.
///
/// Why a taxonomy:
///   - UI can render `error.kind` to a localized message without leaking
///     stack traces or backend internals.
///   - Crashlytics groups by `code` instead of by stack — dashboards stay
///     readable across releases.
///   - Retry / sign-out / re-auth logic branches on `kind` deterministically.
///
/// Convert any [Object] from a try/catch to an [AppError] with [AppError.from].
enum AppErrorKind {
  /// Connection failed; retry possible.
  network,

  /// Request timed out before the server responded.
  timeout,

  /// Authentication missing or expired.
  unauthorized,

  /// Authenticated but lacks permission.
  forbidden,

  /// Validation rejected (4xx other than 401/403/404/429).
  validation,

  /// Resource missing.
  notFound,

  /// Rate-limited; back off.
  throttled,

  /// Server returned 5xx.
  server,

  /// Request was idempotent-replay accepted; treat as success.
  idempotentReplay,

  /// Operation succeeded locally and is queued for background sync.
  /// (Used by offline-first writes; not strictly an error but uses the
  /// same surface.)
  queuedOffline,

  /// Catch-all. Anything we cannot classify.
  unknown,
}

class AppError implements Exception {
  AppError({
    required this.kind,
    required this.code,
    required this.message,
    this.statusCode,
    this.traceId,
    this.cause,
  });

  final AppErrorKind kind;
  final String code;
  final String message;
  final int? statusCode;
  final String? traceId;
  final Object? cause;

  bool get isRetriable =>
      kind == AppErrorKind.network ||
      kind == AppErrorKind.timeout ||
      kind == AppErrorKind.server ||
      kind == AppErrorKind.throttled;

  bool get requiresReauth => kind == AppErrorKind.unauthorized;

  static AppError from(Object e, {StackTrace? stack}) {
    if (e is AppError) return e;
    if (e is DioException) return _fromDio(e);
    return AppError(
      kind: AppErrorKind.unknown,
      code: 'UNKNOWN',
      message: e.toString(),
      cause: e,
    );
  }

  static AppError _fromDio(DioException e) {
    final traceId = e.requestOptions.headers['X-Request-ID'] as String?;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError(
          kind: AppErrorKind.timeout,
          code: 'NETWORK_TIMEOUT',
          message: 'The connection timed out. Try again.',
          statusCode: e.response?.statusCode,
          traceId: traceId,
          cause: e,
        );
      case DioExceptionType.connectionError:
        return AppError(
          kind: AppErrorKind.network,
          code: 'NETWORK_DOWN',
          message: 'You\'re offline. Felo will sync when you\'re back online.',
          traceId: traceId,
          cause: e,
        );
      case DioExceptionType.cancel:
        return AppError(
          kind: AppErrorKind.unknown,
          code: 'CANCELLED',
          message: 'Request cancelled.',
          traceId: traceId,
          cause: e,
        );
      case DioExceptionType.badCertificate:
        return AppError(
          kind: AppErrorKind.network,
          code: 'TLS_CERT',
          message: 'A secure connection could not be established.',
          traceId: traceId,
          cause: e,
        );
      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
        return _fromHttpStatus(e, traceId);
    }
  }

  static AppError _fromHttpStatus(DioException e, String? traceId) {
    final code = e.response?.statusCode ?? 0;
    final body = e.response?.data;
    final serverCode = body is Map<String, dynamic>
        ? body['code']?.toString()
        : null;
    final serverMessage = body is Map<String, dynamic>
        ? body['message']?.toString()
        : null;

    if (code == 401) {
      return AppError(
        kind: AppErrorKind.unauthorized,
        code: serverCode ?? 'UNAUTHORIZED',
        message: serverMessage ?? 'Please sign in again.',
        statusCode: code,
        traceId: traceId,
        cause: e,
      );
    }
    if (code == 403) {
      return AppError(
        kind: AppErrorKind.forbidden,
        code: serverCode ?? 'FORBIDDEN',
        message: serverMessage ?? 'You don\'t have access to that.',
        statusCode: code,
        traceId: traceId,
        cause: e,
      );
    }
    if (code == 404) {
      return AppError(
        kind: AppErrorKind.notFound,
        code: serverCode ?? 'NOT_FOUND',
        message: serverMessage ?? 'That item was not found.',
        statusCode: code,
        traceId: traceId,
        cause: e,
      );
    }
    if (code == 408 || code == 429) {
      return AppError(
        kind: AppErrorKind.throttled,
        code: serverCode ?? 'THROTTLED',
        message: serverMessage ?? 'Too many requests — slow down a moment.',
        statusCode: code,
        traceId: traceId,
        cause: e,
      );
    }
    if (code >= 400 && code < 500) {
      return AppError(
        kind: AppErrorKind.validation,
        code: serverCode ?? 'VALIDATION',
        message: serverMessage ?? 'Some details look off. Please check and try again.',
        statusCode: code,
        traceId: traceId,
        cause: e,
      );
    }
    if (code >= 500) {
      return AppError(
        kind: AppErrorKind.server,
        code: serverCode ?? 'SERVER',
        message: serverMessage ?? 'Felo had a hiccup. Try again in a moment.',
        statusCode: code,
        traceId: traceId,
        cause: e,
      );
    }
    return AppError(
      kind: AppErrorKind.unknown,
      code: 'HTTP_UNKNOWN',
      message: 'Something went wrong.',
      statusCode: code,
      traceId: traceId,
      cause: e,
    );
  }

  @override
  String toString() =>
      'AppError(kind=$kind, code=$code, status=$statusCode, traceId=$traceId, message=$message)';
}
