# Onboarding v2 — Instrumentation Contract

> **Companion to:** [`event-taxonomy.md`](./event-taxonomy.md) · [`funnel-queries.sql`](./funnel-queries.sql)
> **Date:** 2026-04-26 · **Status:** Awaiting Review Gate 6 approval.
>
> Specifies the `OnboardingAnalyticsMixin` that every Phase 1-8 screen must
> implement. **Developers cannot ship a screen without instrumentation** —
> the mixin makes it automatic; route metadata embeds the FR-ID; missing
> instrumentation fails CI.

---

## The contract

Every screen widget in `lib/features/onboarding_v2/presentation/phase*/`
**must** mix in `OnboardingAnalyticsMixin`. The mixin auto-fires:

| Lifecycle | Event |
|---|---|
| `initState()` | `{phase}_{step}_viewed` |
| Continue tap | `{phase}_{step}_completed` |
| Skip tap (if applicable) | `{phase}_{step}_skipped` |
| Back press / swipe | `{phase}_{step}_back` |
| Validation failure | `{phase}_{step}_validation_error{reason}` |

The screen developer never calls `analytics.fire()` directly for these
events. They're fired by the mixin via `super.onContinue()` etc.

---

## Mixin shape

```dart
// lib/features/onboarding_v2/application/onboarding_analytics_mixin.dart

mixin OnboardingAnalyticsMixin<T extends StatefulWidget> on State<T> {
  /// FR ID for this screen — read from route metadata.
  /// Compile-time enforced via lint rule: every screen must declare it.
  String get frdId;
  String get stepId;
  int get phase;

  AnalyticsService get _analytics =>
    ProviderScope.containerOf(context).read(analyticsServiceProvider);

  @override
  void initState() {
    super.initState();
    _fireAnalytics('${stepId}_viewed', {});
  }

  /// Call this from your Continue button. The mixin fires the
  /// completed event with whatever properties you pass.
  Future<void> onContinue([Map<String, dynamic> properties = const {}]) async {
    await _fireAnalytics('${stepId}_completed', properties);
  }

  /// For skip-able steps (Phase 3 permissions, Phase 6 corridor, etc.)
  Future<void> onSkip([Map<String, dynamic> properties = const {}]) async {
    await _fireAnalytics('${stepId}_skipped', properties);
  }

  /// Called automatically by the back-press handler in the parent
  /// FeloOnboardingShell.
  Future<void> onBackPressed() async {
    await _fireAnalytics('${stepId}_back', {});
  }

  /// Call this on inline validation failure. Reason is human-readable
  /// ('empty', 'too_long', 'past_date', etc.) for funnel diagnostics.
  Future<void> onValidationError(String reason) async {
    await _fireAnalytics('${stepId}_validation_error', {'reason': reason});
  }

  Future<void> _fireAnalytics(
    String eventName,
    Map<String, dynamic> properties,
  ) async {
    await _analytics.fire(CanonicalEvent(
      eventName: eventName,
      frdId: frdId,                    // <- enforced; D-001 traceability
      stepId: stepId,
      phase: phase,
      properties: properties,
    ));
  }
}
```

---

## Route metadata defines the FR-ID

```dart
// lib/features/onboarding_v2/presentation/phase4_financial/earning_type_screen.dart

@TypedGoRoute<EarningTypeRoute>(path: '/onboarding/earning-type')
class EarningTypeRoute extends GoRouteData {
  // Route metadata — read by the mixin via context.
  static const phase = 4;
  static const stepId = 'phase4_step1';
  static const frdId = 'FR-4.1.1';     // <- compile-time const

  @override
  Widget build(BuildContext c, GoRouterState s) => const EarningTypeScreen();
}

class EarningTypeScreen extends ConsumerStatefulWidget { ... }

class _EarningTypeScreenState extends ConsumerState<EarningTypeScreen>
    with OnboardingAnalyticsMixin<EarningTypeScreen> {

  @override int get phase => EarningTypeRoute.phase;
  @override String get stepId => EarningTypeRoute.stepId;
  @override String get frdId => EarningTypeRoute.frdId;

  // ... build method, etc.

  void _onContinueTap() {
    if (selections.isEmpty) {
      onValidationError('no_selection');                  // fires _validation_error
      return;
    }
    onContinue({'types': selections.toList()});           // fires _completed with props
    context.go(NextRoute.path);
  }
}
```

---

## CI lint rule

Stage 7 will ship a custom lint rule (`analytics_required.dart`) that
fails any state class extending or descending from a phase route widget
which **does not** mix in `OnboardingAnalyticsMixin`. Rule lives in
`analyzer/plugins/`.

CI fails if:
- A new screen file lands in `phase*/` without the mixin
- A screen has the mixin but doesn't override `frdId` / `stepId` / `phase`
- A screen has the mixin but never calls `onContinue()` (means the
  Continue tap doesn't fire `_completed`)

---

## Cross-cutting events bypass the mixin

Some events are fired **outside** the screen lifecycle:

| Event | Where fired | Fired by |
|---|---|---|
| `welcome_viewed` | App launch / first route | `WelcomeScreen` (which still uses the mixin) |
| `ip_region_resolved` | NestJS `RegionResolveController` | Server-side via `AnalyticsDispatcher.dispatch()` |
| `sms_otp_sent` | NestJS `SmsOtpController` | Server-side |
| `phase7_message_shown` | Loading screen status-message cycler | Programmatic, fired from controller as messages cycle |
| `phase8_dashboard_viewed` | Dashboard handoff stub | Mixin (it's a screen) |
| `state_persist_*` | `OnboardingController.continueToNext()` | Programmatic |
| `funnel_session_*` | Backend on first event arrival / 30-min idle / completion | Server-side `FunnelSessionService` |

For all of these, `analytics.fire()` is called directly with the
appropriate FR-ID. **The traceability rule still applies**: every
direct call must include an `frdId`.

---

## Property guidelines

What goes in `properties`:

✅ **Do include:**
- Selection counts (e.g., `{count: 4}` for accounts selected)
- Categorical answers (e.g., `{method: 'google'}`)
- Validation outcome reason (e.g., `{reason: 'too_long'}`)
- Boolean flags relevant to the funnel (e.g., `{deferred: true}`)
- Numeric durations when meaningful (e.g., `{duration_ms: 4200}`)

❌ **Don't include:**
- Raw user input (names, emails, phone numbers — PII; never send to GTM/Meta)
- Free-text "other" values (use a hashed token if needed for cohort
  analysis)
- Account balances (out of scope and PII-adjacent)
- Sensitive content (OTP codes, passwords, tokens — these never leave
  the auth flow)

---

## PII handling at the dispatcher

The Flutter mixin sends events to `POST /v1/analytics/event`. The NestJS
`AnalyticsDispatcher` handles PII before fanning out to sinks:

| Sink | What's sent | What's redacted |
|---|---|---|
| Postgres `events` | Full canonical payload | IP redacted to country (`ip_country` only) |
| GTM dataLayer | Full payload returned to client → client pushes | (client-side; subject to GTM container's tag rules) |
| Meta CAPI | Hashed email + phone (`em`, `ph`); IP + UA passed through for match-quality | No raw PII |

---

## Funnel session lifecycle (server-side)

The `FunnelSessionService` (NestJS) maintains `funnel_sessions` rows:

```
1. First event for a session_id → INSERT funnel_sessions row with
   started_at = NOW(), last_step_reached = event.step_id

2. Every subsequent event → UPDATE funnel_sessions
   SET last_step_reached = event.step_id

3. No event for 30 minutes → background job marks
   abandoned_at = last_event_time, abandoned_step = last_step_reached

4. On `phase8_dashboard_viewed` → UPDATE
   completed_at = NOW(), abandoned_at = NULL (in case of resume)
```

This makes funnel queries (queries #1, #2, #4 in `funnel-queries.sql`)
fast — no need to scan the events table for last-event-per-session.

---

## Sample event POST payload

```json
POST /v1/analytics/event
Authorization: Bearer <supabase_jwt>
Content-Type: application/json

{
  "event_name": "phase4_step1_completed",
  "frd_id": "FR-4.1.3",
  "step_id": "phase4_step1",
  "phase": 4,
  "session_id": "8f3c2d1e-0123-4567-89ab-cdef01234567",
  "occurred_at": "2026-04-26T19:42:01.234Z",
  "properties": {
    "types": ["salaried", "investor"],
    "custom_value": false
  },
  "meta": {
    "user_agent": "Felo/2.0 (iOS 17.5; iPhone15,2)",
    "locale": "en-CA"
  }
}

← Response:
{
  "ok": true,
  "gtmPayload": {
    "event": "phase4_step1_completed",
    "frdId": "FR-4.1.3",
    "phase": 4,
    "earningTypes": ["salaried", "investor"]
  }
}
```

The Flutter mixin then calls `dataLayer.push(response.gtmPayload)` via
the platform JS bridge.

---

## Sign-off checklist for Review Gate 6

- [ ] Every Phase 1-8 screen will use `OnboardingAnalyticsMixin`
- [ ] CI lint rule design is acceptable (fails on missing instrumentation)
- [ ] PII handling at dispatcher is correct
- [ ] Funnel session lifecycle is correct
- [ ] Conversion event mapping (Meta Standard Events) is approved
- [ ] No event in event-taxonomy.md lacks an FR-ID

When all checked, reply **"approved, continue"** and Stage 7 (Implementation)
starts.

---

## Stage 7 trigger conditions

Per the brief, Stage 7 cannot start until **all of the following** are true:

1. Stages 0-6 review gates approved
2. MaxMind GeoLite2 license procured (US-0.4)
3. Meta CAPI access token + pixel ID procured (US-0.5)
4. GTM container created + dataLayer hooks designed (US-0.6)
5. At least one signed SMS vendor contract (Twilio fallback acceptable)

Any of these missing → Stage 7 can't ship. Sprint 1's E0 epic includes
stories for all of them so they happen in parallel with E0 dev work.
