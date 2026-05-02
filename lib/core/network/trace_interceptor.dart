import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

/// Attaches an `X-Request-ID` to every outbound request and surfaces the
/// echoed-back trace ID on response.
///
/// The backend's CurrentUserMiddleware respects an inbound X-Request-ID
/// (validated against a safe-charset regex) and includes it in all logs +
/// the `X-Request-ID` response header. Crashlytics + Sentry attach the
/// same value on mobile-side error reports, so a single ID stitches the
/// entire request through:
///
///   user device  →  Crashlytics breadcrumb
///   ↓
///   X-Request-ID =  felo-<uuid v4>
///   ↓
///   backend pino log + Sentry tag
///   ↓
///   audit-log row
class TraceInterceptor extends Interceptor {
  TraceInterceptor({Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  final Uuid _uuid;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.putIfAbsent(
      'X-Request-ID',
      () => 'felo-${_uuid.v4()}',
    );
    handler.next(options);
  }
}
