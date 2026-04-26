# Onboarding v2 — Event Taxonomy

> **Companion to:** [`funnel-queries.sql`](./funnel-queries.sql) · [`instrumentation-contract.md`](./instrumentation-contract.md) · [FRD](../03-frd/frd-onboarding.md)
> **Date:** 2026-04-26 · **Status:** Awaiting Review Gate 6 approval.
>
> Every event in the onboarding journey, with its FR-ID, properties,
> intended sinks, and validation hypothesis (where applicable).
> **Traceability rule (D-001) is absolute** — every event carries its
> `frd_id`. If an event doesn't trace, it's noise; remove it or add the
> missing FR.

---

## Canonical event payload (all sinks)

```ts
{
  event_name: string,           // e.g. 'phase4_step1_completed'
  frd_id: string,               // e.g. 'FR-4.1.3'
  step_id: string,              // e.g. 'phase4_step1'
  phase: number,                // 1-8 (or 0 for welcome)
  user_id: string | null,       // null pre-Phase-1
  session_id: string,
  occurred_at: ISODateTime,
  properties: Record<string, unknown>,  // event-specific
  meta: {
    user_agent: string,
    ip_country: string,         // server-redacted from raw IP
    locale: string,
  }
}
```

---

## E0 — Welcome (pre-auth)

| Event | FR | Properties | H | Sinks |
|---|---|---|---|---|
| `welcome_viewed` | FR-1.1.1 | none | — | P + G + M |
| `welcome_cta_tapped` | FR-1.1.1 | none | — | P + G + M |
| `welcome_signin_link_tapped` | FR-1.1.1 | none | — | P + G + M |

P=Postgres, G=GTM, M=Meta CAPI.

---

## Phase 1 — Identity

| Event | FR | Properties | H | Sinks |
|---|---|---|---|---|
| `signup_method_picker_viewed` | FR-1.2.1 | none | — | P + G + M |
| `signup_method_selected` | FR-1.2.2..6 | `{method: 'google'|'apple'|'facebook'|'email'|'mobile'}` | H11 | P + G + M |
| `signup_completed` | FR-1.2.2..6 | `{method, duration_ms}` | H11 | P + G + M |
| `signup_failed` | FR-1.2.* | `{method, reason}` | — | P |
| `email_otp_requested` | FR-1.2.5 | none | — | P |
| `sms_otp_sent` | FR-1.2.6, FR-12.0.3 | `{provider, country, masked_phone}` | — | P |
| `otp_screen_viewed` | FR-1.3.1 | `{channel:'email'|'sms'}` | — | P + G + M |
| `otp_submitted` | FR-1.3.1 | `{channel}` | — | P |
| `otp_verified` | FR-1.3.2 | `{channel, attempts_used}` | — | P + G + M |
| `otp_failed` | FR-1.3.1 | `{channel, reason:'wrong'|'expired'|'max_attempts'}` | — | P |
| `otp_resend_tapped` | FR-1.3.1 | `{channel, resend_count}` | — | P |
| `phase1_completed` | E1 done | `{method, duration_ms}` | — | P + G + M |

### Funnel hypothesis check
- **H11** (OAuth lifts Phase 1 completion ≥95% vs ≥70% email/mobile) → query
  `signup_completed` grouped by `method`.

---

## Phase 2 — Region & Profile

| Event | FR | Properties | H | Sinks |
|---|---|---|---|---|
| `ip_region_resolved` | FR-2.1.0 | `{country, confidence}` | H1 | P |
| `ip_region_resolve_failed` | FR-2.1.0 | `{reason:'timeout'|'rate_limit'|'no_data'}` | — | P |
| `phase2_step1_viewed` | FR-2.1.1 | `{ip_country, prefilled:bool}` | H1 | P + G + M |
| `phase2_step1_completed` | FR-2.1.2 | `{primary_region, prefilled:bool}` | H1 | P + G + M |
| `phase2_step1_back` | FR-2.1.* | none | — | P |
| `secondary_region_added` | FR-2.1.3 | `{country}` | — | P |
| `secondary_region_removed` | FR-2.1.3 | `{country}` | — | P |
| `phase2_step2_viewed` | FR-2.2.1 | `{prefilled:bool}` | — | P |
| `phase2_step2_completed` | FR-2.2.2 | none | — | P + G + M |
| `phase2_step2_validation_error` | FR-2.2.2 | `{reason:'empty'|'too_long'}` | — | P |
| `phase2_completed` | E2 done | none | — | P + G + M |

### Funnel hypothesis check
- **H1** (IP-pre-detected region beats manual) → ratio of
  `phase2_step1_completed{prefilled:true}` to `prefilled:false` divided by
  population of each.

---

## Phase 3 — Permissions

| Event | FR | Properties | H | Sinks |
|---|---|---|---|---|
| `phase3_viewed` | FR-3.0.1 | `{platform}` | — | P + G + M |
| `phase3_sms_grant` | FR-3.1.1 | none | H3 | P + G + M |
| `phase3_sms_skip` | FR-3.1.1 | none | H3 | P |
| `phase3_notif_grant` | FR-3.2.1 | none | — | P + G + M |
| `phase3_notif_skip` | FR-3.2.1 | none | — | P |
| `phase3_location_grant` | FR-3.3.1 | none | — | P |
| `phase3_location_skip` | FR-3.3.1 | none | — | P |
| `phase3_contacts_skip` | FR-3.4.1 | none (always; no actual perm) | — | P |
| `phase3_completed` | FR-3.0.2 | `{sms:bool, notif:bool, location:bool}` | — | P + G + M |

### Funnel hypothesis check
- **H3** (SMS grant rate ≥75%) → `phase3_sms_grant` / (`phase3_sms_grant` + `phase3_sms_skip`)

---

## Phase 4 — Financial Profile

| Event | FR | Properties | H | Sinks |
|---|---|---|---|---|
| `phase4_step1_viewed` | FR-4.1.1 | none | H4 | P + G + M |
| `earning_type_toggled` | FR-4.1.2 | `{type, selected:bool}` | — | P |
| `phase4_step1_completed` | FR-4.1.3 | `{types[], custom_value:bool}` | H4 | P + G + M |
| `phase4_step2_viewed` | FR-4.2.1 | `{region, list_size}` | H8 | P + G + M |
| `phase4_step2_secondary_toggle` | FR-4.2.2 | `{enabled:bool}` | — | P |
| `phase4_step2_deferred` | FR-4.2.3 | none | — | P + G + M |
| `phase4_step2_completed` | FR-4.2.4 | `{count, deferred:bool}` | H8 | P + G + M |
| `phase4_step3_viewed` | FR-4.3.1 | none | — | P |
| `phase4_step3_completed` | FR-4.3.2 | `{invests:bool}` | — | P + G + M |
| `phase4_step4_viewed` | FR-4.4.1 | none | — | P |
| `phase4_step4_completed` | FR-4.4.2 | `{types[]}` | — | P + G + M |
| `phase4_completed` | E4 done | `{earning_types[], invests:bool, accounts_count, investment_types[]}` | — | P + G + M |

### Funnel hypothesis checks
- **H4** ("Why we ask" microcopy reduces Phase 4.1 drop ≤8%) → drop rate
  on `phase4_step1_viewed` → `phase4_step1_completed`
- **H8** (Region-filtered bank list lifts ≥90% Phase 4.2 completion) →
  drop rate on `phase4_step2_viewed` → `phase4_step2_completed`

---

## Phase 5 — Intent

| Event | FR | Properties | H | Sinks |
|---|---|---|---|---|
| `phase5_step1_viewed` | FR-5.1.1 | `{template_used:string|null, region, top_earning_type}` | H5 | P + G + M |
| `budget_total_edited` | FR-5.1.2 | `{old_total, new_total, currency}` | — | P |
| `budget_category_edited` | FR-5.1.3 | `{category, old, new, semantic}` | — | P |
| `phase5_step1_completed` | FR-5.1.5 | `{total, categories_count, semantic_inflow_count, semantic_outflow_count}` | H5 | P + G + M |
| `phase5_step2_viewed` | FR-5.2.1 | none | H6, H12 | P + G + M |
| `goal_selected` | FR-5.2.2 | `{slug}` | — | P |
| `goal_deselected` | FR-5.2.2 | `{slug, reason:'manual'|'fifo'}` | — | P |
| `goal_third_tap_seen` | FR-5.2.2 | none — fires when premium upsell note shows | — | P + M |
| `phase5_step2_detail_viewed` | FR-5.2.3 | `{slot, slug}` | — | P |
| `goal_warning_shown` | FR-5.2.5 | `{required, available, currency}` | — | P |
| `goal_warning_dismissed_via_continue` | FR-5.2.5 | none | — | P |
| `goal_warning_jumped_to_budget` | FR-5.2.5 | none | — | P |
| `phase5_step2_completed` | FR-5.2.6 | `{slots:[{slug, currency, target_minor, target_date, monthly_contrib_minor}]}` | H6, H12 | P + G + M |
| `phase5_completed` | E5 done | `{total, currency, goal_count:2, currencies_used[]}` | — | P + G + M |

### Funnel hypothesis checks
- **H5** (Budget pre-fills lift Phase 5.1 ≥85%) → completion conditioned
  on `template_used != null`
- **H6** (2-goal limit beats unlimited) → 90-day cohort retention with goal
  contributions vs no-goal cohort
- **H12** (Phase 5.2 redesign lifts goals completion vs legacy) →
  flag-gated A/B post-launch

---

## Phase 6 — Remittance

| Event | FR | Properties | H | Sinks |
|---|---|---|---|---|
| `phase6_step1_viewed` | FR-6.1.1 | none | H9 | P + G + M |
| `family_remittance_option_toggled` | FR-6.1.2 | `{slug, selected}` | — | P |
| `phase6_step1_completed` | FR-6.1.3 | `{options[], step2_will_fire:bool}` | H9 | P + G + M |
| `phase6_step2_viewed` | FR-6.2.1 | `{prefilled_send_to[], prefilled_receive_from[]}` | — | P + G + M |
| `corridor_country_toggled` | FR-6.2.2 | `{direction, country}` | — | P |
| `phase6_step2_completed` | FR-6.2.3 | `{sends_to[], receives_from[]}` | — | P + G + M |
| `phase6_completed` | E6 done | `{skipped:bool}` | — | P + G + M |

### Funnel hypothesis check
- **H9** (Domestic-only users not hurt by 6.2 skip) → satisfaction
  measure (D7 NPS) on users with `step2_will_fire:false`

---

## Phase 7 — Personalization

| Event | FR | Properties | H | Sinks |
|---|---|---|---|---|
| `phase7_started` | FR-7.0.1 | none | H7 | P + G + M |
| `phase7_message_shown` | FR-7.1.1 | `{template_key}` | — | P |
| `phase7_message_completed` | FR-7.1.1 | `{template_key, duration_ms}` | — | P |
| `phase7_timeout` | FR-7.1.2 | `{template_key, elapsed_ms}` | — | P |
| `phase7_core_error` | FR-7.1.2 | `{attempt}` | — | P |
| `phase7_support_escape` | FR-7.1.2 | none | — | P |
| `phase7_completed` | FR-7.1.3 | `{duration_ms, degraded:bool}` | H7 | P + G + M |
| `app_backgrounded_during_phase7` | FR-7.1.1 | none | H7 | P |

### Funnel hypothesis check
- **H7** (Phase 7 backgrounding ≤5%) → `app_backgrounded_during_phase7`
  count / `phase7_started` count

---

## Phase 8 — Dashboard handoff (north-star event)

| Event | FR | Properties | H | Sinks |
|---|---|---|---|---|
| `phase8_dashboard_viewed` | FR-8.1.1 | `{widget_count, has_investments:bool, has_remittance:bool, accounts_deferred:bool, primary_region, currency}` | **NORTH STAR** | P + G + M |
| `tooltip_first_account_shown` | FR-8.2.1 | none | — | P |
| `tooltip_first_account_dismissed` | FR-8.2.1 | none | — | P |
| `dashboard_widget_tapped` | FR-8.1.* | `{widget:'greeting'|'currency'|'account_tile'|'budget_ring'|'goal_card'|'investment'|'remittance'|'earning_widget', target_id?}` | — | P + G + M |
| `onboarding_completed` | E8 done | `{total_duration_ms, screens_seen, persona_signature}` | **NORTH STAR** | P + G + M |

`phase8_dashboard_viewed` and `onboarding_completed` are the two events
Marketing/Growth wires to **conversion** events in Meta CAPI + GTM. Hard
KPI for paid-channel attribution.

---

## Cross-cutting events

### State persistence

| Event | FR | Sinks |
|---|---|---|
| `state_persist_local_success` | FR-11.0.1 | P |
| `state_persist_remote_success` | FR-11.0.2 | P |
| `state_persist_remote_failed` | FR-11.0.2 | P |
| `onboarding_resumed` | FR-11.0.3 | P + G + M |
| `state_invalidation_cascade` | FR-11.0.4 | P |

### Journey config

| Event | FR | Sinks |
|---|---|---|
| `journey_config_fetched` | FR-9.0.1 | P |
| `journey_config_refreshed` | FR-9.0.2 | P |

### Analytics meta

| Event | FR | Sinks |
|---|---|---|
| `analytics_dispatch_failed` | FR-10.0.2 | P (only — meta-event for ops) |

### Funnel-session lifecycle

| Event | FR | Sinks |
|---|---|---|
| `funnel_session_started` | FR-10.0.6 | P |
| `funnel_session_abandoned` | FR-10.0.6 | P |
| `funnel_session_completed` | FR-10.0.6 | P |

---

## Per-screen `_back` events

Every Phase 1-8 screen also fires a `{phase}_{step}_back` event when user
taps the back button. Generated automatically by the
`OnboardingAnalyticsMixin` (see `instrumentation-contract.md`). Not listed
exhaustively above to avoid noise; treated as a single event family for
funnel queries.

---

## Per-screen `_validation_error` events

When inline validation fails (FR-2.2.2 empty name, FR-5.2.4 goal date <30d,
etc.), the mixin fires `{phase}_{step}_validation_error{reason}`. Used for
form-design quality measurement (high error rates → worse copy or worse
UX).

---

## Total event count

| Category | Events |
|---|---|
| E0 Welcome | 3 |
| Phase 1 Identity | 12 |
| Phase 2 Region | 10 |
| Phase 3 Permissions | 9 |
| Phase 4 Financial | 12 |
| Phase 5 Intent | 14 |
| Phase 6 Remittance | 7 |
| Phase 7 Personalization | 8 |
| Phase 8 Dashboard | 5 |
| Cross-cutting (state, config, meta, funnel) | 11 |
| Per-screen `_back` (16 screens × 1 each) | 16 |
| Per-screen `_validation_error` (variable) | ~10 |
| **Total** | **~117 events** |

---

## Conversion events (Meta CAPI specific)

Marketing maps these to Meta's Standard Events for ad attribution:

| FELO event | Meta Standard Event | Purpose |
|---|---|---|
| `signup_completed` | `CompleteRegistration` | Signup conversion |
| `phase5_step2_completed` | `AddToWishlist` | Goal commitment signal |
| `phase8_dashboard_viewed` | `Lead` | Onboarding-complete conversion |
| `onboarding_completed` | `Subscribe` | High-intent conversion |

These are the events Marketing should set bid optimization toward.

---

## Sign-off checklist for Review Gate 6

- [ ] Every FR from Stage 4's FRD has at least one event tracing to it
- [ ] All 12 hypotheses (H1-H12) from Stage 1's discovery have at least
      one query-able event signal
- [ ] North-star event (`phase8_dashboard_viewed` / `onboarding_completed`)
      is wired to all 3 sinks
- [ ] Conversion event mapping to Meta Standard Events is approved
- [ ] No event lacks an FR-ID
