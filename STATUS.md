# appuifelo — Status

> Last updated: 2026-04-30
> See [program dashboard](https://github.com/RizwanZafaris/felo-docs/blob/main/STATUS.md).

## Purpose
Flutter mobile app for FELO. Riverpod + Freezed v3 + Retrofit.

## Owner squads
Capture · Remittance · Identity · Intelligence · Monetization.

## Current head
- branch: `main`
- last commit: [`c3cf822`](https://github.com/RizwanZafaris/appuifelo/commit/c3cf822) — merge `fix/build-errors`
- log: https://github.com/RizwanZafaris/appuifelo/commits/main

## Feature modules (lib/features/)

| Feature | State | Notes |
|---|---|---|
| accounts | real | wired to backend |
| auth | real | Supabase Auth |
| bills | real | recurring detection |
| budgets | real | thresholds + alerts |
| cash_envelopes | real | new |
| coach | real | LLM chat + rules |
| do_hub | real | shortcut hub |
| export_control | real | GDPR controls |
| family | stub | hardcoded members — Sprint 3 |
| goals | real | progress + nudges |
| home_dashboard | real | summary cards |
| investments | stub | UI only — Sprint 6 |
| kyc | stub | placeholder — Sprint 4 |
| monthly_close | real | validate + lock |
| notifications | partial | feed only, no push — Sprint 5 |
| onboarding_v2 | real | 8-phase |
| profile | real | settings |
| receipt_capture | stub | OCR mocked — Sprint 2 |
| referrals | real | code + share |
| remittance_notebook | real | manual logging |
| remittance_stub | delete | superseded — drop in Sprint 2 |
| reports | real | weekly + monthly |
| send_money | delete | superseded by remittance_notebook — drop in Sprint 2 |
| sms_parser | stub | hardcoded list — Sprint 1 |
| splits | real | 4-step wizard |
| subscriptions | partial | UI only, paywall TBD — Sprint 4 |
| transactions | real | CRUD + receipts |

## Active PRs

| PR | Title | Squad | State |
|---|---|---|---|
| _none yet_ | | | |

## Open feature branches
- `feat/F005-insights-ui`
- `feat/F006-goals-polish`
- `feat/F007-splits-ui`
- `feat/F008-investments-ui`
- `feat/F009-coach-ui`
- `feat/F010-mfa-ui`
- `feat/F011-referrals-ui`
- `feat/F012-notifications-ui`
- `feat/onboarding-v2-stage-0`
- `codex/felo-stitch-design-coverage`
- `fix/build-errors` (merged)

## Build & test gates

| Gate | Target | Last check |
|---|---|---|
| `flutter analyze` | 0 errors | ✅ 2026-04-30 (141 info/warn) |
| `flutter test` coverage | ≥ 40% | ~10% (gap) |

## How to update
- Mobile squad-leads: update "Feature modules" + "Active PRs" when PRs open.
- All edits via PR; only Claude Code merges to `main`.
