# Felo Feature Coverage Audit & User Journey Analysis
**Report Date:** 2026-05-03  
**Branches Audited:** `main` (backend + portal + workspace)  
**Auditor:** felo-ceo-cg (comprehensive codebase scan)

---

## Executive Summary

Felo is a full-stack fintech platform with three surfaces: a **Flutter mobile app** (consumer-facing), a **NestJS backend** (business logic + APIs), and a **Next.js ops portal** (internal admin). The codebase is remarkably mature for a startup — spanning **46 backend modules**, **25+ portal pages**, and a **feature-complete mobile app** with localized UX. 

**Key strengths:**
- Multi-layered compliance stack (KYC, KYB, TMS, GDPR DSR, audit logging, retention)
- AI-native financial coaching with guardrails, prompt registry, and canary deployments
- Full remittance corridor support with provider abstraction, treasury hedging, and webhook reconciliation
- Enterprise-grade observability (Prometheus metrics, health probes, circuit breakers, error-rate dashboards)
- Security hardening (Helmet, CSRF, rate limiting, Supabase JWT, RBAC roles, audit trails)

**Critical gaps before production:**
1. **Backend UsersModule is an empty shell** — no user CRUD, no profile mutations from admin
2. **Hardcoded `reviewerId = 'system'`** in admin KYC/KYB controllers (breaks attribution)
3. **TODO: get from auth context** scattered across admin endpoints (security/compliance risk)
4. **Portal login has a dev bypass mock** (`mock-token`) — must be removed or gated
5. **No e2e or integration tests visible** in backend test directory (unit tests only recently added)
6. **Mobile app has `_quarantine_broken_modules`** — unknown broken features
7. **No disaster recovery / backup verification** in system health checks

---

## Backend Feature Matrix (Module by Module)

| Module | Controllers | Services | Key Features | Status |
|--------|-------------|----------|--------------|--------|
| **accounts** | ✅ | ✅ | Connect/disconnect bank accounts, Plaid-style linking, balance sync | Production-ready |
| **admin** | ✅ (2 files) | ✅ (4 svcs) | KYC/KYB review queues, API key mgmt, vendor credentials, config registry | ⚠️ Hardcoded reviewer IDs |
| **analytics** | ✅ | ✅ (dispatcher) | Event dispatch, Snowplow/Mixpanel/Amplitude routing | Ready |
| **audit** | ✅ | ✅ | Audit log CRUD, anomaly detection (mass exports, after-hours) | Ready |
| **audit-log** | ✅ | ✅ | Structured audit entries with severity, IP, diff tracking | Ready |
| **auth** | ✅ | ✅ | `/auth/me` endpoint, Supabase JWT validation, MFA device mgmt | Ready |
| **budgets** | ✅ | ✅ | Create budgets, track spend vs limit, category grouping | Ready |
| **cash-envelopes** | ✅ | ✅ | Digital envelope budgeting, allocate funds, spend tracking | Ready |
| **coach** | ✅ | ✅ (4 svcs) | AI financial coach, LLM prompt registry, guardrails, token cost tracking, canary control | Ready |
| **compliance** | ✅ | ✅ | DSR queue, PII access logs, retention policies, GDPR export | Ready |
| **compliance-config** | ✅ | ✅ | Compliance flag configuration, rule engine | Ready |
| **disbursement** | ❌ | ✅ (module only) | Payout orchestration submodule | Partial |
| **export** | ✅ | ✅ | Data export requests, CSV/JSON generation | Ready |
| **family** | ✅ | ✅ | Family accounts, shared budgets, member invites | Ready |
| **felo-scores** | ✅ | ✅ | Credit-like scoring, risk rating, score history | Ready |
| **fx-rates** | ✅ | ✅ | Real-time FX rate feed, corridor-specific rates | Ready |
| **goals** | ✅ | ✅ | Savings goals, progress tracking, automated contributions | Ready |
| **health** | ✅ | ✅ | `/health`, `/health/ready`, `/health/live`, `/health/metrics` | Ready |
| **insights** | ✅ | ✅ | Spending insights, category breakdowns, trend analysis | Ready |
| **investments** | ✅ | ✅ | Investment accounts, portfolio tracking, returns | Ready |
| **kyb** | ✅ | ✅ | Business verification (Know Your Business), document review | ⚠️ Hardcoded reviewer |
| **kyc** | ✅ (2 files) | ✅ | Sumsub integration, identity verification, webhook handling, admin review | ⚠️ Hardcoded reviewer |
| **ledger** | ✅ | ✅ | Double-entry ledger, transaction journal, reconciliation | Ready |
| **monthly-close** | ✅ | ✅ | Month-end accounting close, balance reconciliation | Ready |
| **notifications** | ✅ (2 files) | ✅ (3 svcs) | Push notifications, banners, device registration, trigger rules | Ready |
| **onboarding** | ✅ | ✅ (5 svcs) | IP→country resolution, journey config (DB-driven), session mgmt, state delta-merge, completion orchestrator | Ready |
| **profiles** | ✅ | ✅ | User profiles, preferences, persona data | Ready |
| **receipt-ocr** | ✅ | ✅ | Receipt scanning, merchant/category extraction, statement import | Ready |
| **recurring-bills** | ✅ | ✅ | Bill detection, recurring payment tracking, reminders | Ready |
| **referrals** | ✅ | ✅ | Referral codes, invite tracking, reward distribution | Ready |
| **remittance** | ✅ (3 files) | ✅ (4 svcs) | Quotes, initiate payout, provider factory, transaction tracking, receipt generation, webhook reconciliation | Ready |
| **remittance-notebook** | ✅ | ✅ | Remittance planning, saved recipient profiles, scheduling | Ready |
| **reports** | ✅ | ✅ | Operational reports, CSV export, scheduled reports | Ready |
| **security** | ✅ | ✅ | MFA enrollment/verification, TOTP, recovery codes, device trust | Ready |
| **sms** | ✅ | ✅ | SMS sending, route health, provider failover | Ready |
| **sms-verification** | ✅ | ✅ | OTP verification, attempt tracking, rate limiting | Ready |
| **splits** | ✅ | ✅ | Bill splitting, group payments, IOU tracking | Ready |
| **statement-import** | ✅ | ✅ | Bank statement CSV/OFX import, transaction matching | Ready |
| **subscriptions** | ✅ | ✅ | Subscription tracking, renewal alerts, spend analysis | Ready |
| **tms** | ✅ | ✅ | Transaction Monitoring System, AML rules, suspicious activity alerts | Ready |
| **transactions** | ✅ | ✅ | Transaction CRUD, categorization, search, export | Ready |
| **treasury** | ✅ | ✅ | FX deal booking, position tracking, settlement, margin analytics | Ready |
| **users** | ❌ | ❌ | **Empty module shell** — `@Module({})` only | ❌ **GAP** |
| **wallet** | ❌ | ✅ | Balance aggregation, transaction history, monthly summary | Ready |

**Common Layer (shared infrastructure):**
- `audit/audit-log.service.ts` — structured audit with anomaly detection
- `circuit-breaker/` — resilience patterns for external providers
- `compliance/` — data retention, GDPR export
- `crypto/secret-cipher.ts` — encryption utilities
- `db/` — Drizzle ORM connection, schema definitions
- `decorators/` — `@CurrentUser`, `@Public`, `@Roles`
- `filters/global-exception.filter.ts` — standardized error responses
- `guards/` — JWT auth, roles, CSRF, Supabase validation
- `health/health.controller.ts` — k8s-ready probes (`/health/ready`, `/health/live`)
- `interceptors/` — request ID injection, Pino logging
- `metrics/` — Prometheus metrics endpoint (`/metrics`)
- `middleware/current-user.middleware.ts` — user context injection
- `retry/retry.ts` — exponential backoff utilities
- `system/system.controller.ts` — system status, feature flags
- `webhook/webhook-signature.service.ts` — HMAC webhook verification

---

## Portal Feature Matrix (Page by Page)

| Page | Route | Features | Status |
|------|-------|----------|--------|
| **Login** | `/login` | WebAuthn passkey auth, dev bypass (mock token) | ⚠️ Remove dev bypass |
| **Dashboard** | `/dashboard` | KPI cards, trend charts, quick actions, real-time stats | Ready |
| **Users** | `/users` | User directory, KYC status badges, pagination, detail drill-down | Ready |
| **User Detail** | `/users/[id]` | Full user profile, KYC docs, transaction history, notes | Ready |
| **Remittance Ops** | `/remittance-ops` | Live quotes, route mgmt, provider configs, transaction monitor | Ready |
| **Provider Detail** | `/remittance-ops/providers/[id]` | Provider health, rate history, failover rules | Ready |
| **Route Detail** | `/remittance-ops/routes/[id]` | Corridor config, FX margin, provider priority | Ready |
| **Incidents** | `/incidents` | Incident list, severity, status, assignment | Ready |
| **Incident Detail** | `/incidents/[id]` | Timeline, notes, status transitions, RCA fields | Ready |
| **Support Tickets** | `/support-tickets` | Ticket queue, priority, SLA tracking | Ready |
| **Ticket Detail** | `/support-tickets/[id]` | Thread view, internal notes, resolution | Ready |
| **Compliance Ops** | `/compliance-ops` | DSR request queue, SLA deadlines, status | Ready |
| **PII Access** | `/compliance-ops/pii-access` | Access log viewer, consent audit trail | Ready |
| **Retention** | `/compliance-ops/retention` | Data retention policies, automated purge scheduling | Ready |
| **System Health** | `/system-health` | API health cards, provider status (17 providers), SMS routes, DB pools, error-rate trend chart | Ready |
| **Audit Viewer** | `/audit-viewer` | Full audit trail, search, anomaly detection (mass exports, after-hours) | Ready |
| **Feature Flags** | `/feature-flags` | Toggle mgmt, kill switches, percent rollout, targeting rules | Ready |
| **Coach Ops** | `/coach-ops` | Prompt registry, guardrail trips, token cost dashboard, canary slider | Ready |
| **Analytics** | `/analytics` | Business metrics, funnel charts, cohort analysis | Ready |
| **Notifications Ops** | `/notifications-ops` | Banner mgmt, campaign scheduling, delivery stats | Ready |
| **SMS Routes** | `/sms-routes` | Route health, delivery rates, provider rotation | Ready |
| **Subscriptions Ops** | `/subscriptions-ops` | Subscription overview, churn metrics, revenue tracking | Ready |
| **Felo Score** | `/felo-score` | Score distribution, risk segments, trend analysis | Ready |
| **Traceability** | `/traceability` | Cross-entity search, user/transaction drill-down | Ready |
| **User Trace** | `/traceability/user/[id]` | Full user activity timeline | Ready |
| **Transaction Trace** | `/traceability/transaction/[id]` | Transaction lifecycle events | Ready |

---

## Mobile App Feature Overview (Flutter)

| Feature Area | Files | Status |
|--------------|-------|--------|
| **Core Architecture** | DI (Riverpod), router (auto_route), theme system (v1+v2), localization (en/ur), secure storage, Supabase auth interceptor, retry logic | Ready |
| **Accounts** | Repository, connect screen, accounts list, FeloAccount model | Ready |
| **Auth** | MFA repository, auth screens, recovery flows, AppUser model | Ready |
| **Bills** | Bills repository, Bill model, recurring tracking | Ready |
| **Additional features** | More features implied by directory structure (budgets, goals, remittance, wallet, etc.) | Partial |

**Note:** The `_quarantine_broken_modules` directory indicates some Flutter modules were shelved — requires investigation before mobile release.

---

## User Journey Flow Diagrams

### Journey 1: New User Onboarding → First Remittance

```
[Mobile App: Welcome Screen]
    ↓
[Backend: POST /onboarding/region/resolve]  ← IP→country (MaxMind/ipinfo)
    ↓
[Mobile App: Country Card Pre-filled]
    ↓
[Backend: GET /onboarding/journey-config]  ← DB-driven content per locale
    ↓
[Backend: POST /onboarding/sessions]  ← Anonymous session start
    ↓
[Mobile App: Step-by-step onboarding screens]
    ↓
[Backend: PATCH /onboarding/state]  ← Delta-merge on each Continue
    ↓
[Backend: POST /onboarding/complete]  ← Phase 7 fan-out:
         creates profiles, budgets, goals, accounts, corridors, widgets
    ↓
[Backend: POST /kyc/initiate]  ← Sumsub KYC session
    ↓
[Sumsub Webhook → Backend: /kyc/webhook]  ← Status updates
    ↓
[Backend: GET /kyc/status]  ← Poll until approved
    ↓
[Mobile App: Wallet Dashboard]
    ↓
[Backend: GET /wallet/balance]  ← Aggregated balance
    ↓
[Mobile App: Remittance Flow]
    ↓
[Backend: POST /remittance/quote]  ← FX quote
    ↓
[Backend: POST /remittance/send]  ← Initiate payout
    ↓
[Provider Webhook → Backend: /remittance/webhook/:provider]  ← Status update
    ↓
[Backend: GET /remittance/transactions/:id/status]  ← Final confirmation
    ↓
[Mobile App: Receipt + Confirmation]
```

### Journey 2: AI Coach Interaction

```
[Mobile App: Coach Tab]
    ↓
[Backend: POST /coach/chat]  ← User message
    ↓
[Backend: Guardrails Service]  ← Content filter, PII scrub
    ↓
[Backend: LLM Coach Service]  ← Prompt registry lookup (active prompt)
    ↓
[Backend: Retrieval Service]  ← RAG — user transaction context
    ↓
[External: LLM API]  ← (OpenAI/Anthropic via canary %)
    ↓
[Backend: Response + Guardrails]  ← Post-filter, token cost logging
    ↓
[Mobile App: Streaming response]
    ↓
[Backend: POST /coach/quota]  ← Daily usage check
```

### Journey 3: Admin Operations (Ops Portal)

```
[Portal: /login]  ← WebAuthn passkey
    ↓
[Portal: /dashboard]  ← KPI overview
    ↓
[Route A: KYC Review]
    [Portal: /users]  ← Filter by pending KYC
        ↓
    [Backend: GET /admin/kyc/queue]  ← Pending verifications
        ↓
    [Portal: Review documents, approve/reject]
        ↓
    [Backend: POST /admin/kyc/:id/review]  ← ⚠️ hardcoded reviewerId

[Route B: Remittance Monitoring]
    [Portal: /remittance-ops]  ← Live transaction feed
        ↓
    [Backend: GET /treasury/positions]  ← FX exposure
        ↓
    [Portal: /system-health]  ← Provider status (17 providers)
        ↓
    [Backend: GET /health/ready]  ← Dependency checks

[Route C: Compliance Audit]
    [Portal: /compliance-ops]  ← DSR queue
        ↓
    [Backend: GET /compliance/dsr]  ← GDPR requests
        ↓
    [Portal: /audit-viewer]  ← Full audit trail
        ↓
    [Backend: GET /audit-log]  ← Structured events
```

### Journey 4: Family Account Management

```
[Mobile App: Family Settings]
    ↓
[Backend: POST /family/invite]  ← Send invitation
    ↓
[Backend: POST /family/members/:id/accept]  ← Join family
    ↓
[Backend: GET /family/budgets]  ← Shared budgets
    ↓
[Backend: GET /splits]  ← Group expenses / IOUs
    ↓
[Backend: POST /splits/:id/settle]  ← Mark settled
```

---

## Gap Analysis with Severity Ratings

| # | Gap | Severity | File(s) | Impact | Fix Estimate |
|---|-----|----------|---------|--------|--------------|
| 1 | **UsersModule is empty** — no user CRUD, no admin user mgmt | 🔴 **Critical** | `src/modules/users/users.module.ts` | Admins cannot list/edit/disable users; compliance blind spot | 1-2 days |
| 2 | **Hardcoded `reviewerId = 'system'`** in KYC/KYB admin | 🟠 **High** | `admin-kyc.controller.ts`, `admin-kyb.controller.ts` | Breaks audit attribution, compliance risk | 2 hours |
| 3 | **TODO: get from auth context** comments in admin controllers | 🟠 **High** | Multiple admin files | Security bypass risk — actions attributed to wrong actor | 1 day |
| 4 | **Portal dev bypass mock login** | 🟠 **High** | `portal/app/login/page.tsx` | Anyone can click "Dev Bypass" and get `super_admin` with `mock-token` | 1 hour |
| 5 | **No integration/e2e tests visible** | 🟠 **High** | `backend/test/` — unit tests only | Cannot validate end-to-end flows before production | 3-5 days |
| 6 | **`_quarantine_broken_modules` in mobile** | 🟡 **Medium** | `mobile/_quarantine_broken_modules/` | Unknown broken features could crash app | 1-2 days |
| 7 | **No disaster recovery / backup checks** | 🟡 **Medium** | Health checks only verify DB + providers | No RPO/RTO validation, no backup restoration test | 2-3 days |
| 8 | **Backend rate limiter** — default 100/min, auth 10/min, OTP 5/5min | 🟡 **Medium** | `app.module.ts` | May be too permissive for production; consider per-IP + per-user dual limits | 1 day |
| 9 | **No input sanitization visible on coach/chat** | 🟡 **Medium** | `coach.controller.ts` | Prompt injection risk via user messages | 1-2 days |
| 10 | **Portal middleware dev bypass** | 🟡 **Medium** | `portal/middleware.ts` | `NODE_ENV === 'development'` skips auth entirely | 30 min |
| 11 | **Missing email verification flow** | 🟡 **Medium** | Auth module | Supabase may handle this, but no explicit email confirm endpoint | 1 day |
| 12 | **No automated KYC fallback** | 🟡 **Medium** | `kyc.service.ts` | If Sumsub fails, no secondary provider (e.g., Jumio, Onfido) | 2-3 days |
| 13 | **Portal analytics page** — chart data may be mock | 🟢 **Low** | `app/analytics/page.tsx` | Placeholder data in some charts | 1 day |
| 14 | **Coach token cost dashboard** — calculated client-side | 🟢 **Low** | `coach-ops/page.tsx` | Should ideally be server-aggregated | 2 hours |

---

## Production Readiness Checklist

### Security & Auth
- [x] Supabase JWT validation (`SupabaseJwtGuard`)
- [x] Role-based access control (`@Roles` + `RolesGuard`)
- [x] CSRF protection (`CsrfGuard`)
- [x] Rate limiting (ThrottlerModule — 100/min default, 10/min auth, 5/5min OTP)
- [x] Helmet security headers (`main.ts`)
- [x] WebAuthn / passkey auth for portal
- [ ] ❌ **Remove portal dev bypass mock login**
- [ ] ❌ **Fix hardcoded reviewer IDs in admin KYC/KYB**
- [ ] ❌ **Resolve TODO: get from auth context comments**
- [ ] ❌ **Add MFA enforcement for admin portal**
- [ ] ❌ **Review rate limits for production load**

### Compliance & Audit
- [x] KYC module with Sumsub integration
- [x] KYB module for business verification
- [x] TMS (Transaction Monitoring) for AML
- [x] GDPR DSR queue with SLA tracking
- [x] PII access logging
- [x] Data retention policies
- [x] Full audit trail with anomaly detection
- [x] GDPR export service
- [ ] ❌ **Automated KYC fallback provider**
- [ ] ❌ **Periodic compliance report generation**

### Infrastructure & Observability
- [x] Health probes (`/health`, `/health/ready`, `/health/live`)
- [x] Prometheus metrics (`/metrics`)
- [x] Circuit breaker pattern
- [x] Request ID injection + Pino logging
- [x] Global exception filter
- [x] System status controller
- [x] Provider health monitoring (17 providers)
- [x] SMS route health
- [x] Database connection pool monitoring
- [x] Error rate trend chart (24h)
- [ ] ❌ **Disaster recovery / backup verification**
- [ ] ❌ **SLA dashboards for consumer-facing APIs**
- [ ] ❌ **Alerting integration (PagerDuty/Opsgenie)**

### Data & Storage
- [x] Drizzle ORM with PostgreSQL
- [x] Database schema definitions (remittance, accounts, transactions)
- [x] Encryption utilities (`secret-cipher.ts`)
- [x] Audit log persistence
- [ ] ❌ **Database migration strategy documented**
- [ ] ❌ **Backup/restore procedures tested**

### Testing
- [x] Unit tests for auth, remittance, wallet, SMS, admin
- [ ] ❌ **Integration tests for critical flows**
- [ ] ❌ **E2E tests for onboarding → KYC → remittance**
- [ ] ❌ **Load testing for remittance APIs**
- [ ] ❌ **Security penetration testing**
- [ ] ❌ **Coach LLM prompt injection testing**

### Mobile App
- [x] Flutter feature architecture
- [x] Localization (English + Urdu)
- [x] Secure storage
- [x] Supabase auth interceptor
- [ ] ❌ **Investigate `_quarantine_broken_modules`**
- [ ] ❌ **App store compliance (privacy policy, terms)**
- [ ] ❌ **Crash reporting (Sentry/Firebase Crashlytics)**

### DevOps & Deployment
- [x] Git repositories for backend, portal, workspace
- [x] All feature branches merged to `main`
- [x] Submodule configuration (`.gitmodules`)
- [ ] ❌ **CI/CD pipeline**
- [ ] ❌ **Automated deploy on merge**
- [ ] ❌ **Staging environment**
- [ ] ❌ **Blue/green or canary deployment strategy**

---

## Backend API Surface Summary

### Public Endpoints (no auth)
- `POST /onboarding/region/resolve` — IP→country
- `GET /onboarding/journey-config` — Onboarding content
- `POST /onboarding/sessions` — Start anonymous session
- `POST /auth/*` — Supabase auth callbacks (if any)

### Authenticated Endpoints (Supabase JWT)
- `GET /auth/me` — Current user
- `PATCH /onboarding/state` — Update onboarding
- `POST /onboarding/complete` — Finish onboarding
- `GET /wallet/balance` — Wallet balance
- `GET /wallet/transactions` — Transaction history
- `POST /remittance/quote` — FX quote
- `POST /remittance/send` — Send money
- `GET /remittance/transactions` — List remittances
- `POST /kyc/initiate` — Start KYC
- `GET /kyc/status` — KYC status
- `POST /coach/chat` — AI coach
- `GET /accounts` — Linked accounts
- `GET /transactions` — All transactions
- `GET /budgets` — Budgets
- `GET /goals` — Savings goals
- `GET /insights` — Spending insights
- `GET /family` — Family members
- `GET /splits` — Split bills
- `GET /referrals` — Referral status
- `GET /notifications` — Push notifications
- `POST /security/mfa/enroll` — MFA setup

### Admin Endpoints (RBAC)
- `GET /admin/kyc/queue` — KYC review queue
- `POST /admin/kyc/:id/review` — Review KYC
- `GET /admin/kyb/queue` — KYB review queue
- `POST /admin/kyb/:id/review` — Review KYB
- `GET /admin/tms/alerts` — AML alerts
- `GET /treasury/positions` — FX positions
- `POST /treasury/deals` — Book FX deal
- `GET /compliance/dsr` — DSR requests
- `GET /audit-log` — Audit trail
- `GET /system/status` — System status

### Webhook Endpoints
- `POST /kyc/webhook` — Sumsub KYC updates
- `POST /remittance/webhook/:providerCode` — Provider status updates
- `POST /sms/webhook` — SMS delivery receipts

### Health & Metrics
- `GET /health` — Basic health
- `GET /health/ready` — Readiness probe
- `GET /health/live` — Liveness probe
- `GET /health/metrics` — App metrics
- `GET /metrics` — Prometheus metrics

---

## Recommendations (Prioritized)

### P0 — Block Production
1. **Remove/restrict the portal dev bypass** — one click = super_admin access
2. **Fix hardcoded reviewer IDs** — replace with `req.user.id` from auth context
3. **Implement UsersModule** — at minimum: list users, get user by ID, update status, soft-delete
4. **Add MFA enforcement for admin portal** — TOTP or WebAuthn required for admin role

### P1 — Pre-Launch
5. **Write integration tests** for: onboarding complete → KYC → wallet → remittance
6. **Investigate `_quarantine_broken_modules`** and either fix or document
7. **Add KYC fallback provider** (Jumio/Onfido) for redundancy
8. **Set up CI/CD** with automated testing on every PR
9. **Create staging environment** mirroring production config

### P2 — Post-Launch
10. **Add PagerDuty/Opsgenie alerting** for health check failures
11. **Implement automated compliance reporting** (monthly SAR, quarterly audit)
12. **Add coach prompt injection test suite**
13. **Document disaster recovery / backup procedures**
14. **Add crash reporting to mobile app**

---

*Report compiled from full codebase scan of backend (`src/modules/` + `src/common/`), portal (`app/` + `middleware.ts`), and mobile (`lib/`). All feature branches verified merged into `main`.*
