import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_analytics_service.dart';

/// Per-screen instrumentation contract — every Phase 1-8 onboarding screen
/// MUST mix this in. The mixin auto-fires viewed/completed/skipped/back/
/// validation_error events with the FR-ID baked in via the screen's
/// override of [frdId] / [stepId] / [phase].
///
/// Per D-001, traceability is absolute: every event carries its FR-ID.
/// The CI lint rule (Stage 7 follow-up: `analytics_required.dart` analyzer
/// plugin) will fail any screen in `phase*/` that doesn't mix this in or
/// doesn't override the three required getters.
///
/// **Usage:**
/// ```dart
/// class _EarningTypeScreenState extends ConsumerState<EarningTypeScreen>
///     with OnboardingAnalyticsMixin<EarningTypeScreen> {
///   @override int    get phase  => 4;
///   @override String get stepId => 'phase4_step1';
///   @override String get frdId  => 'FR-4.1.1';
///
///   void _onContinueTap() {
///     if (selections.isEmpty) {
///       onValidationError('no_selection');
///       return;
///     }
///     onContinue({'types': selections.toList()});
///     context.go(NextRoute.path);
///   }
/// }
/// ```
mixin OnboardingAnalyticsMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  static const _uuid = Uuid();
  static String _sessionId = _uuid.v4();

  /// Stable session id across the journey. Reset only when the user
  /// explicitly starts a fresh onboarding (resume keeps the original).
  static String get sessionId => _sessionId;
  static void resetSession() {
    _sessionId = _uuid.v4();
  }

  /// FR-ID this screen traces to. Required override.
  String get frdId;

  /// Step id (e.g. 'phase4_step1'). Required override.
  String get stepId;

  /// Phase number 0-8. Required override.
  int get phase;

  bool _viewedFired = false;

  @override
  void initState() {
    super.initState();
    if (!_viewedFired) {
      _viewedFired = true;
      _fire('${stepId}_viewed');
    }
  }

  /// Call from the screen's Continue handler. Optionally pass
  /// event-specific [properties] for the funnel.
  Future<void> onContinue([Map<String, Object?> properties = const {}]) {
    return _fire('${stepId}_completed', properties);
  }

  /// Call when the user explicitly skips a skippable step.
  Future<void> onSkip([Map<String, Object?> properties = const {}]) {
    return _fire('${stepId}_skipped', properties);
  }

  /// Auto-fired by the parent shell on back press. Screens don't call
  /// this directly.
  Future<void> onBackPressed() {
    return _fire('${stepId}_back');
  }

  /// Call on inline validation failure with a human-readable [reason]
  /// like 'empty', 'too_long', 'past_date'.
  Future<void> onValidationError(String reason) {
    return _fire('${stepId}_validation_error', {'reason': reason});
  }

  Future<void> _fire(
    String eventName, [
    Map<String, Object?> properties = const {},
  ]) {
    return ref
        .read(onboardingAnalyticsServiceProvider.notifier)
        .fire(
          CanonicalEvent(
            eventName: eventName,
            frdId: frdId,
            stepId: stepId,
            phase: phase,
            sessionId: sessionId,
            occurredAt: DateTime.now(),
            properties: properties,
          ),
        );
  }
}
