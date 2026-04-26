import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/network/dio_provider.dart';

part 'onboarding_analytics_service.g.dart';

/// Canonical event payload — must match NestJS `CreateEventDto` shape.
class CanonicalEvent {
  const CanonicalEvent({
    required this.eventName,
    required this.frdId,
    required this.stepId,
    required this.phase,
    required this.sessionId,
    required this.occurredAt,
    this.properties = const {},
    this.userAgent,
    this.locale,
  });

  final String eventName;
  final String frdId;
  final String stepId;
  final int phase;
  final String sessionId;
  final DateTime occurredAt;
  final Map<String, Object?> properties;
  final String? userAgent;
  final String? locale;

  Map<String, Object?> toJson() => {
        'event_name': eventName,
        'frd_id': frdId,
        'step_id': stepId,
        'phase': phase,
        'session_id': sessionId,
        'occurred_at': occurredAt.toUtc().toIso8601String(),
        'properties': properties,
        'meta': {
          if (userAgent != null) 'user_agent': userAgent,
          if (locale != null) 'locale': locale,
        },
      };
}

/// Multi-sink analytics emitter (Flutter side of D-030).
///
/// Posts canonical events to NestJS `POST /v1/analytics/event`. The server
/// fans out to (a) Postgres `events` table — internal source of truth,
/// (b) Meta CAPI server-side — Facebook ad attribution, (c) returns a GTM
/// payload for the client to `dataLayer.push` via JS bridge / native plugin.
///
/// Mechanism rule: when sinks are inactive (env vars unset on the server),
/// they enter stub mode and no client code change is needed. Drop in
/// credentials → live.
@riverpod
class OnboardingAnalyticsService extends _$OnboardingAnalyticsService {
  @override
  void build() {
    // No state — service exposes async fire() only.
  }

  Future<void> fire(CanonicalEvent event) async {
    final dio = ref.read(dioProvider);
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/analytics/event',
        data: event.toJson(),
      );
      // Server returns { ok, gtm_payload, sinks }. Push to GTM dataLayer
      // if a payload was returned.
      final gtmPayload = response.data?['gtm_payload'];
      if (gtmPayload is Map<String, dynamic>) {
        await _pushToDataLayer(gtmPayload);
      }
    } catch (_) {
      // Analytics failures must never block the user. Swallow.
      // (In production, route to Sentry/Crashlytics for ops visibility.)
    }
  }

  /// Push to GTM dataLayer via platform bridge.
  ///
  /// E0 stub: prints the payload in debug mode. Stage 7 sub-epic for
  /// US-0.6 wires the actual dataLayer.push (Web: `js.context.callMethod`;
  /// Mobile: `firebase_analytics` GA4 SDK or a custom platform channel
  /// that posts to a hidden WebView containing the GTM container).
  ///
  /// Mechanism rule: when `gtm_container_id` is null in the payload
  /// (server has no `GTM_CONTAINER_ID` env), this stays a no-op silently.
  Future<void> _pushToDataLayer(Map<String, dynamic> payload) async {
    final containerId = payload['gtm_container_id'];
    if (containerId == null) {
      // Server says GTM is in formatter-only mode — skip the push.
      return;
    }
    // TODO(US-0.6): wire the real dataLayer.push here.
    // E0 stub leaves this as a no-op even when GTM is active server-side
    // — the contract is correct but the bridge isn't ported until US-0.6
    // closes (GTM container procurement + JS bridge / native plugin).
    final _ = payload;
  }
}
