# Felo Backend & Portal — CTO Gap Report

**Date:** 2026-05-02
**Scope:** `backend/src/modules/*`, `portal/app/*`, `db/schema`, build & deploy configs
**Severity Legend:** 🔴 Critical | 🟠 High | 🟡 Medium | 🟢 Low

---

## 1. Executive Summary

The codebase is in a **pre-launch, partially broken state**. While several security primitives (Supabase JWT verification, MFA crypto, helmet headers) are well-implemented, the project **cannot compile as-is** due to missing modules and broken import paths. ~30 backend modules exist but are unwired, and a large quarantined batch of Kimi-generated modules (KYC, payments, statement-import, etc.) are not integrated. The admin/officer portal has a **fundamental auth mismatch** that will block ops login. Rate limiting, feature-flag backend, and comprehensive testing are all absent.

**Top 5 blockers for public launch:**
1. 🔴 Build fails — `app.module.ts` references non-existent modules.
2. 🔴 Admin auth is broken — `SupabaseJwtGuard` rejects the custom admin token returned by `/admin/auth/login`.
3. 🟠 No rate limiting / throttling wired up.
4. 🟠 Remittance provider credentials stored as plain JSON in DB (not encrypted).
5. 🟠 Zero test coverage on remittance, treasury, ledger, and transactions core logic.

---

## 2. Existing Modules & Features

### 2.1 Backend (`backend/src/modules/`)

| Module | Status | Wired in `AppModule` | Notes |
|--------|--------|----------------------|-------|
| `auth` | ✅ Exists | ✅ | Echo-only `/auth/me`; no real auth logic |
| `profiles` | ✅ Exists | ❌ | Replaces missing `UsersModule`; CRUD for user profiles |
| `accounts` | ✅ Exists | ❌ | Bank/wallet account management |
| `admin` | ✅ Exists | ❌ | Config registry, vendor credentials, 2-person approval, WebAuthn stub |
| `analytics` | ✅ Exists | ❌ | Analytics dispatcher (unwired) |
| `audit` | ✅ Exists | ❌ | Treasury audit logging (Squad 2/3/4 style) |
| `audit-log` | ✅ Exists | ❌ | App-wide audit log service + cursor pagination |
| `budgets` | ✅ Exists | ❌ | Budget management |
| `cash-envelopes` | ✅ Exists | ❌ | Cash envelope feature |
| `coach` | ✅ Exists | ❌ | LLM coach, guardrails, prompts |
| `compliance` | ✅ Exists | ❌ | DSR requests, PII access logging, retention |
| `disbursement` | ✅ Exists | ⚠️ Broken path | Lives under `remittance/` but imported as `modules/disbursement` |
| `export` | ✅ Exists | ❌ | Data export orchestration |
| `family` | ✅ Exists | ❌ | Family groups & members |
| `felo-scores` | ✅ Exists | ❌ | Felo score formula & overrides |
| `fx-rates` | ✅ Exists | ❌ | FX rate ingestion & overrides |
| `goals` | ✅ Exists | ❌ | Financial goals |
| `health` | ✅ Exists | ❌ | Liveness + DB probe |
| `insights` | ✅ Exists | ❌ | Spending insights |
| `investments` | ✅ Exists | ❌ | Investment tracking |
| `ledger` | ✅ Exists | ✅ | Ledger entries |
| `monthly-close` | ✅ Exists | ❌ | Month-end close workflow |
| `notifications` | ✅ Exists | ❌ | Banners, triggers, device tokens |
| `onboarding` | ✅ Exists | ❌ | Multi-phase onboarding, geo-resolve, journey config |
| `recurring-bills` | ✅ Exists | ❌ | Recurring bill tracking |
| `referrals` | ✅ Exists | ❌ | Referral codes & tracking |
| `remittance` | ✅ Exists | ✅ | Routes, quotes, send, history, 15+ payout providers |
| `remittance-notebook` | ✅ Exists | ❌ | Notebook entries |
| `reports` | ✅ Exists | ❌ | Report generation |
| `security` | ✅ Exists | ❌ | MFA (TOTP + recovery codes) |
| `sms` | ✅ Exists | ✅ | SMS sending (primary) |
| `sms-verification` | ✅ Exists | ❌ | SMS parser & bank route verification |
| `splits` | ✅ Exists | ❌ | Bill splitting |
| `statement-import` | ✅ Exists | ❌ | OFX/CSV import |
| `subscriptions` | ✅ Exists | ❌ | Subscription tiers & billing |
| `transactions` | ✅ Exists | ❌ | Transaction CRUD |
| `treasury` | ✅ Exists | ✅ | Treasury / cash management |
| `ledger` | ✅ Exists | ✅ | Double-entry ledger |

**Missing from `src/modules/` (imported in `AppModule` but directories absent):**
- `users` → `profiles` exists but is not imported; `auth.users` is managed by Supabase.
- `kyc` → Schema tables (`kycDocuments`, `kycDecisions`) exist but no backend module.
- `wallet` → No `wallet` table in schema; only `accounts.type = 'wallet'` enum.

### 2.2 Quarantined Modules (`backend/_quarantine_broken_modules/`)

These were Kimi-generated but do not compile against the current schema. They include:

- `kyc` (full KYC workflow)
- `payments` (payment processing)
- `categorization` (transaction categorization)
- `receipt-ocr` (enhanced OCR adapters)
- `statement-import` (enhanced parsers)
- `sms-parser` (SMS parsing engine)
- `fx-rates` (FX rate service — a simpler version exists in `src/modules/fx-rates`)
- `investments-extras` (investment analytics)
- `coach-extras` (coach extensions)
- `notifications-admin` / `notifications-extras`
- `admin` (guards, decorators, JWT auth for admin)
- `common-interceptors`, `common-services`
- `config` (quarantined config module)
- `i18n`
- `integrations` (third-party integrations)
- `remittance-providers` (older provider implementations)

**Impact:** Core fintech features (KYC, payments, enhanced OCR, SMS parsing, categorization) are **not available** in the running app.

### 2.3 Portal (`portal/app/`)

| Page / Feature | Status |
|----------------|--------|
| Login (WebAuthn stub) | ✅ |
| Dashboard | ✅ |
| Users list + detail | ✅ |
| Remittance Ops (providers, FX override, compliance flags) | ✅ |
| SMS Routes + parser templates | ✅ |
| Subscriptions (tiers, coupons, refunds) | ✅ |
| Coach Ops (prompts, guardrails, token costs) | ✅ |
| Felo Score (formula, overrides, distribution) | ✅ |
| Notifications (templates, campaigns, banners) | ✅ |
| Compliance (DSR, PII access log, retention) | ✅ |
| Feature Flags (list, create, kill) | ✅ UI only — **no backend service** |
| Analytics (cohorts, funnel, MRR, LTV) | ✅ |
| Audit Viewer | ✅ |
| Traceability | ✅ |

---

## 3. Build & Compilation

| Gap | Severity | Details |
|-----|----------|---------|
| `app.module.ts` imports non-existent modules | 🔴 Critical | `UsersModule`, `KycModule`, `WalletModule` dirs are missing. `DisbursementModule` is imported from `modules/disbursement/` but lives under `modules/remittance/`. `npm run build` will fail. |
| ~30 existing modules unwired | 🟠 High | `profiles`, `accounts`, `transactions`, `budgets`, `goals`, `coach`, `compliance`, `onboarding`, `security`, etc. are not in `AppModule` imports. They are dead code. |
| Quarantined modules not integrated | 🟠 High | KYC, payments, categorization, statement-import, receipt-ocr, SMS parser are all quarantined. Need schema reconciliation + re-integration. |
| No build CI verification | 🟡 Medium | `tsconfig.json` excludes `_quarantine_broken_modules`, but nothing prevents committing broken imports in `src/`. |

---

## 4. Authentication & Authorization

| Gap | Severity | Details |
|-----|----------|---------|
| Admin auth is broken | 🔴 Critical | `AdminController` applies `@UseGuards(SupabaseJwtGuard)` class-wide. `/admin/auth/login` returns a random hex token (not a Supabase JWT). The portal sends `Authorization: Bearer <hex-token>` via `api.ts` interceptor. `SupabaseJwtGuard` will reject every admin call. |
| No RBAC enforcement on backend | 🟠 High | `portal/lib/rbac.ts` has a rich permission matrix (super_admin, ops_manager, support_lead, analyst, etc.) and `hasPermission()` helpers. The backend `AdminController` does **not** check any of these permissions. Any valid Supabase JWT (or bypass in dev) can hit all admin endpoints. |
| `JwtAuthGuard` is a no-op shim | 🟡 Medium | It exists for backward compat but does nothing. Real enforcement is `SupabaseJwtGuard`. This is acceptable if documented, but confusing. |
| Portal middleware bypasses auth in dev | 🟡 Medium | `middleware.ts` skips auth entirely when `NODE_ENV === 'development'`. Easy to miss auth bugs locally. |
| Portal session in `localStorage` | 🟡 Medium | `saveSession()` stores admin token in `localStorage`. XSS can steal it. Should use `httpOnly` cookies. |
| Admin token hashing mismatch | 🟠 High | `AdminController.getMe()` SHA-256 hashes the `x-admin-token` header before DB lookup, but `adminAuth.login()` stores the raw token in `adminSessions.token`. The hash is never written to the DB, so `getMe` will always fail unless the stored token is also hashed (it isn't). |
| No `Public()` on `/admin/auth/login` | 🟠 High | The login endpoint is inside a controller guarded by `SupabaseJwtGuard`. Users can't log in because the guard blocks unauthenticated access to the login route itself. |

---

## 5. Security (Infrastructure & Secrets)

| Gap | Severity | Details |
|-----|----------|---------|
| No rate limiting / throttling | 🟠 High | `@nestjs/throttler` is in `package.json` but **zero** references in source. No `ThrottlerModule`, no `ThrottlerGuard`, no per-endpoint decorators. |
| Remittance credentials stored as plain JSON | 🟠 High | `remittanceProviders.credentials` is `jsonb` with no encryption. Provider factory loads these directly into `ProviderConfig.credentials`. `VendorCredentialsService` encrypts credentials in a separate table but is **never used** by payout providers. |
| `FELO_DATA_ENCRYPTION_KEY` dev fallback | 🟡 Medium | `secret-cipher.ts` falls back to a hardcoded dev key in non-prod. Safe because it throws in prod, but dev/staging data could be trivially decrypted if leaked. |
| CORS config is acceptable | 🟢 Low | Prod requires explicit `CORS_ORIGINS`; dev opens to all origins. Acceptable for current stage. |
| Helmet headers present | 🟢 Low | CSP, HSTS, frame-ancestors in prod. Good. |
| Trust proxy restricted | 🟢 Low | Only loopback/linklocal/uniquelocal in prod. Good. |
| Body parser cap | 🟢 Low | `1mb` limit on JSON/URL-encoded. File uploads use per-controller multer overrides. Good. |
| Supabase publishable key in `.env.example` | 🟡 Medium | `sb_publishable_Gp5pDHYMML1658kptTOMcQ_O-pUQVAt` is committed. Even "publishable" keys should not be in version control. |
| No CSRF tokens | 🟡 Medium | No CSRF protection on state-changing POST/PATCH/DELETE endpoints. Mitigated somewhat by JWT Bearer requirement, but not for cookie-based sessions. |
| No secrets scanning / pre-commit hooks | 🟡 Medium | No evidence of `detect-secrets`, `git-secrets`, or similar. |

---

## 6. Input Validation & DTOs

| Gap | Severity | Details |
|-----|----------|---------|
| `RemittanceController` accepts raw untyped bodies | 🟠 High | `POST /remittance/quote`, `POST /remittance/send`, `POST /remittance/status/:id` all accept `body: any` (or inline TS types) with **no `class-validator` decorators**. The global `ValidationPipe` with `forbidNonWhitelisted: true` will whitelist them to empty objects or pass through raw data. |
| `RemittanceAdminController` same issue | 🟠 High | Admin CRUD for providers/routes uses inline types (`body: any`) without DTOs. |
| `AdminController` mostly unvalidated | 🟠 High | Endpoints like `/admin/auth/register`, `/admin/auth/login`, `/admin/v1/config`, `/admin/v1/vendor-credentials` accept raw objects. No DTO classes. |
| `DisbursementController` validated | 🟢 Low | Uses `CreateOrderDto` and `CursorPaginationDto` with class-validator. Good. |
| `OnboardingController` validated | 🟢 Low | Uses `StartOnboardingSessionDto`, `PatchOnboardingStateDto`, etc. Extensive decorators. Good. |
| `MfaController` validated | 🟢 Low | Uses `VerifyMfaDto`. Good. |
| `ProfilesController` validated | 🟢 Low | Uses `UpdateMeDto`. Good. |

---

## 7. Error Handling

| Gap | Severity | Details |
|-----|----------|---------|
| `GlobalExceptionFilter` is solid | 🟢 Low | Catches all, normalizes to RFC 7807 problem-details JSON (`type`, `title`, `status`, `detail`). Good pattern. |
| Services throw raw `Error` for business logic | 🟠 High | `DisbursementService.createOrder()` throws `new Error('Amount exceeds KYC tier...')`. `GlobalExceptionFilter` maps these to **500 Internal Server Error** instead of 400 Bad Request. Users see 500 for their own limit violations. |
| No structured error codes | 🟡 Medium | Onboarding uses `D-xxx` invariant codes in error messages, but most modules do not. Hard to programmatically handle errors. |

---

## 8. Database Schema & Migrations

| Gap | Severity | Details |
|-----|----------|---------|
| Schema is comprehensive | 🟢 Low | 45+ tables covering profiles, accounts, transactions, budgets, goals, investments, remittance, KYC, compliance, feature flags, admin users, audit logs, etc. |
| No RLS policies in Drizzle schema | 🟡 Medium | RLS is likely in SQL migrations (`db/supabase/`), but the Drizzle schema file does not declare them. Risk of drift between code and DB. |
| Migrations exist | 🟢 Low | `db/supabase/000_init.sql` through `010_s1_s2_backend.sql`. 11 migration files. |
| No `drizzle-kit` push CI check | 🟡 Medium | `db:push` script exists but no CI gate to ensure migrations are in sync with schema. |
| `profiles.id` is FK to `auth.users(id)` | 🟢 Low | Correct Supabase Auth pattern. No separate `users` table. |

---

## 9. API Structure & Contracts

| Gap | Severity | Details |
|-----|----------|---------|
| Swagger/OpenAPI only in non-prod | 🟢 Low | Acceptable for launch; disable in prod. |
| Admin API surface is huge (~60 endpoints) | 🟡 Medium | `api.ts` defines ~60 admin endpoints. Backend `AdminController` only implements a handful (auth, config, vendor-credentials). Most admin endpoints called by the portal **do not have backend implementations** (users CRUD, refunds, feature flags, coach prompts, etc.). |
| Missing admin endpoints | 🟠 High | Portal calls `/admin/users`, `/admin/subscriptions/tiers`, `/admin/remittance/quotes`, `/admin/feature-flags`, `/admin/coach/prompts`, `/admin/notifications/templates`, etc. None of these exist in the backend controllers. |

---

## 10. Observability (Logging, Metrics, Alerting)

| Gap | Severity | Details |
|-----|----------|---------|
| `nestjs-pino` installed & wired | 🟢 Low | Logger is attached. Basic request logging. |
| No metrics endpoint (Prometheus) | 🟡 Medium | No `/metrics`, no `@willsoto/nestjs-prometheus` or similar. Can't monitor request rates, latency, DB pool saturation. |
| No Sentry / error tracking | 🟡 Medium | `SENTRY_DSN` env var is documented but never used in code. No Sentry integration. |
| No distributed trace IDs | 🟡 Medium | No correlation IDs across requests. Hard to trace a remittance flow across services. |
| No structured request logging with user context | 🟡 Medium | Pino is present but no custom serializers for `req.user` or payout provider latency. |

---

## 11. Feature Toggles / Flags

| Gap | Severity | Details |
|-----|----------|---------|
| `featureFlags` table exists in schema | 🟢 Low | Columns: `key`, `isEnabled`, `killSwitch`, `audience`, `version`, etc. Proper indexes. |
| No backend service / controller | 🟠 High | Zero backend code references `featureFlags`. The portal has a full feature-flags UI (`portal/app/feature-flags/page.tsx`) and `api.ts` helpers, but calling them will 404. |
| No feature flag evaluation middleware | 🟡 Medium | No interceptor or guard that checks `killSwitch` before allowing access to new endpoints. |

---

## 12. Offline-First Capability

| Gap | Severity | Details |
|-----|----------|---------|
| Not applicable to backend | — | — |
| Portal has no service worker / sync queue | 🟡 Medium | No `workbox`, no `navigator.serviceWorker`, no IndexedDB sync layer for offline admin actions. Not a blocker for MVP but needed for mobile resilience. |

---

## 13. Scalability & Performance

| Gap | Severity | Details |
|-----|----------|---------|
| Postgres pool `max: 10` | 🟡 Medium | Fine for early stage, but no configuration to scale with load. No read replicas. |
| No caching layer (Redis) | 🟡 Medium | FX rates, remittance routes, journey config are DB-hits on every request. No Redis or in-memory TTL cache. |
| No message queue | 🟡 Medium | Payout webhooks, SMS ingestion, receipt OCR, and statement import would benefit from a queue (BullMQ, SQS). Currently synchronous. |
| No read-replica routing | 🟢 Low | All reads go to the primary Supabase DB. |
| Provider factory loads all providers on boot | 🟡 Medium | `onModuleInit` hits `remittanceProviders` table. OK unless table grows to thousands. |
| Cursor pagination is base64-encoded integers | 🟢 Low | Simple and effective for current scale. |

---

## 14. Testing

| Gap | Severity | Details |
|-----|----------|---------|
| Jest configured | 🟢 Low | `test`, `test:cov`, `test:e2e` scripts present. |
| No backend test directory (`test/`) | 🟠 High | No e2e tests for the Nest app. No integration tests for DB. |
| Core business logic untested | 🟠 High | `remittance.service.ts`, `disbursement.service.ts`, `treasury.service.ts`, `ledger.service.ts`, `transactions.service.ts` have **zero** spec files. |
| Quarantined tests are broken | 🟡 Medium | 10 spec files in `_quarantine_broken_modules/` are excluded from build but reference old schemas. |
| Existing specs are narrow | 🟡 Medium | `health.controller.spec.ts`, `profiles.service.spec.ts`, `otp-attempt.service.spec.ts`, `guardrails.service.spec.ts`, etc. cover small utilities but not integration paths. |
| Portal tests minimal | 🟡 Medium | 3 Playwright e2e specs (dashboard, login, users) + `rbac.test.ts` + `utils.test.ts`. Very surface-level. |

---

## 15. DevOps & Deployment

| Gap | Severity | Details |
|-----|----------|---------|
| Dockerfile is solid | 🟢 Low | Multi-stage, Alpine, drops privileges, healthcheck. Good. |
| `docker-compose.yml` has hardcoded dev secrets | 🟡 Medium | `JWT_SECRET: dev-secret-change-me...` is fine for local dev but should be `.env`-driven. |
| No CI/CD config visible | 🟡 Medium | No `.github/workflows/`, no `gitlab-ci.yml`. No automated build/test/deploy gates. |
| `npm_package_version` in health check | 🟢 Low | Reads from env; acceptable. |

---

## 16. Recommended Sprint Plan (Priority Order)

### Sprint A — Unblock Build & Auth (Days 1–2)
1. Fix `app.module.ts` imports:
   - Remove `UsersModule`, `KycModule`, `WalletModule`.
   - Change `DisbursementModule` import path to `./modules/remittance/disbursement.module`.
   - Wire in `ProfilesModule`, `SecurityModule`, `OnboardingModule`, `TransactionsModule`, etc. (or prune unwired modules).
2. Fix admin auth:
   - Add `@Public()` to `/admin/auth/login` and `/admin/auth/register`.
   - **OR** remove `SupabaseJwtGuard` from `AdminController` and implement a custom `AdminAuthGuard` that validates `x-admin-token`.
   - Fix `AdminAuthService.getMe()` to look up the raw token (not SHA-256 hash) or hash on insert.
3. Add RBAC guard to admin endpoints:
   - Create `AdminRoleGuard` that checks `adminUsers.role` against required permissions.
4. Add `@nestjs/throttler` to `AppModule` with sensible defaults (e.g., 100 req/min per IP, 10 req/min for auth endpoints).

### Sprint B — Remittance Security & Validation (Days 3–4)
5. Create DTOs for `RemittanceController` and `RemittanceAdminController` (`QuoteDto`, `SendDto`, `CreateProviderDto`, etc.).
6. Migrate provider credentials to `VendorCredentialsService`:
   - Encrypt credentials before storing in `vendorCredentials`.
   - Decrypt at runtime in `PayoutProviderFactory` before passing to `provider.initialize()`.
   - Delete plain `credentials` column from `remittanceProviders` (or make it a FK reference).
7. Add business-logic error mapping:
   - Convert `DisbursementService` raw `Error` throws into `BadRequestException` or custom `ForbiddenException`.

### Sprint C — Missing Backend Services (Days 5–7)
8. Implement missing admin controllers:
   - `UsersAdminController` (list, detail, force-logout, soft-delete, tier override)
   - `SubscriptionsAdminController` (tiers, coupons, refunds, failed payments)
   - `RemittanceAdminController` (market quotes, FX override, compliance flags)
   - `CoachAdminController` (prompts, guardrails, canary config)
   - `NotificationsAdminController` (templates, campaigns, banners)
   - `FeatureFlagsController` (CRUD + kill switch)
   - `ComplianceController` (DSR, retention)
   - `AnalyticsController` (cohorts, funnel, MRR, LTV)
9. Reconcile and re-integrate quarantined modules (KYC, payments, categorization, statement-import, receipt-ocr, sms-parser) or decide to rebuild.

### Sprint D — Hardening & Observability (Days 8–10)
10. Add Prometheus metrics endpoint (`@willsoto/nestjs-prometheus`) and key counters (payout attempts, failures, latency).
11. Integrate Sentry (or similar) for error tracking in production.
12. Add request correlation ID middleware.
13. Write critical-path tests:
    - Remittance quote → send → status flow.
    - Disbursement create + tier limits.
    - Admin auth + RBAC.
    - Feature flag kill switch.
14. Add Redis caching layer for FX rates and remittance routes.
15. Review all `.env.example` / template files for committed secrets and rotate any exposed keys.

---

## 17. Appendix — File Inventory

### Key Backend Files
- `src/app.module.ts` — module registry (broken)
- `src/main.ts` — bootstrap, helmet, CORS, swagger, validation pipe
- `src/config/config.ts` — env validation (Zod)
- `src/common/guards/supabase-jwt.guard.ts` — JWT verification
- `src/common/filters/global-exception.filter.ts` — RFC 7807 errors
- `src/common/crypto/secret-cipher.ts` — AES-256-GCM + PBKDF2
- `src/modules/remittance/providers/payout.providers.ts` — 77KB, 15+ providers
- `src/modules/remittance/providers/provider-factory.service.ts` — runtime provider loader
- `src/modules/admin/admin-auth.service.ts` — custom hex-token auth
- `src/modules/admin/vendor-credentials.service.ts` — encrypted credential vault (unused)
- `src/modules/security/mfa.service.ts` — TOTP + recovery codes
- `db/schema/index.ts` — Drizzle schema (45+ tables)
- `db/supabase/000_init.sql` … `010_s1_s2_backend.sql` — migrations

### Key Portal Files
- `middleware.ts` — auth bypass in dev
- `lib/auth.ts` — WebAuthn stub + localStorage session
- `lib/api.ts` — Axios client, ~60 admin API helpers
- `lib/rbac.ts` — frontend-only permission matrix
- `app/login/page.tsx` — login UI
- `app/dashboard/page.tsx` — dashboard UI

---

*Report generated by subagent for main agent. Ready for review.*
