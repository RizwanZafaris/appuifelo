import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Attaches the current Supabase access token to every request.
///
/// Tokens are managed by `supabase_flutter` (auto-refreshes on demand),
/// so we just read the current session at request time.
class SupabaseAuthInterceptor extends Interceptor {
  SupabaseAuthInterceptor(this._client);

  final SupabaseClient _client;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final session = _client.auth.currentSession;
    final token = session?.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
