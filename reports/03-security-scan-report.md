# Felo Code Security & Quality Scan Report
**Date:** 2026-05-03  
**Scanner:** felo ceo cg (AI Security Assistant)  
**Scope:** Backend (NestJS), Portal (Next.js), Workspace

---

## 1. Executive Summary

| Category | Status | Count |
|----------|--------|-------|
| 🔴 Critical | **2** | Production blockers requiring immediate fix |
| 🟠 High | **2** | Significant security/quality issues |
| 🟡 Medium | **4** | Should be addressed before public launch |
| 🟢 Low | **2** | Nice-to-fix, not blocking |

**Build Status:** ✅ Backend compiles, ✅ Portal compiles  
**Test Status:** ❌ 19 test suites present but all empty (0 tests passing)  
**Dependencies:** ⚠️ Backend: 28 vulns, Portal: 9 vulns

---

## 2. Critical Issues (P0)

### C-1: Dev Bypass Button in Portal Login (`🔴 CRITICAL`)
**File:** `portal/app/login/page.tsx:129`  
**Issue:** A clickable "Dev Bypass (Mock)" button grants `super_admin` role with hardcoded `mock-token`.  
**Risk:** Anyone who discovers the portal URL can gain full admin access without authentication.  
**Fix:** Remove the bypass button entirely or gate it behind `NODE_ENV !== 'production'`.

```tsx
// REMOVE THIS:
<Button onClick={() => {
  saveSession({
    userId: 'admin-1',
    email: 'admin@felo.io',
    displayName: 'Admin User',
    role: 'super_admin',
    token: 'mock-token',
    expiresAt: Date.now() + 86400000,
  });
}}>
  Dev Bypass (Mock)
</Button>
```

### C-2: Hardcoded `reviewerId = 'system'` in Admin Controllers (`🔴 CRITICAL`)
**Files:**
- `backend/src/modules/kyc/admin-kyc.controller.ts:25`
- `backend/src/modules/kyb/kyb.controller.ts:61`

**Issue:** Admin KYC/KYB approval endpoints use hardcoded `reviewerId = 'system'` instead of the actual authenticated admin's ID.  
**Risk:** All approvals appear to come from "system" — no audit trail of who actually approved. Compliance nightmare.  
**Fix:** Use `@CurrentUser()` decorator to get the real admin ID.

```ts
// BEFORE:
const reviewerId = 'system'; // TODO: get from auth context

// AFTER:
const reviewerId = user.id; // from @CurrentUser() user: RequestUser
```

---

## 3. High Issues (P1)

### H-1: Empty `UsersModule` — No User Management (`🟠 HIGH`)
**File:** `backend/src/modules/users/users.module.ts`  
**Issue:** The module exports nothing. No user service, no user controller.  
**Risk:** Core user operations (profile updates, user lookup, admin user management) are unimplemented.  
**Fix:** Implement `UsersService` and `UsersController` with CRUD operations.

### H-2: 19 Empty Test Suites — Zero Test Coverage (`🟠 HIGH`)
**Files:** `backend/src/modules/**/*.spec.ts` (19 files)  
**Issue:** Every `.spec.ts` file exists but contains no actual test cases ("Your test suite must contain at least one test").  
**Risk:** No automated verification. Any refactor can break the app silently.  
**Fix:** Populate tests with real assertions, or remove empty stubs.

---

## 4. Medium Issues (P2)

### M-1: Dependency Vulnerabilities (`🟡 MEDIUM`)
**Backend:** 28 vulnerabilities (4 low, 17 moderate, 7 high)  
**Portal:** 9 vulnerabilities (5 moderate, 4 high)  
**Key backend issues:**
- `multer` — DoS via uncontrolled recursion (GHSA-5528)
- `picomatch` — Method injection + ReDoS
- `webpack` — SSRF via allowedUris bypass
- `tmp` — Arbitrary file write via symlink

**Key portal issues:**
- `next` — Multiple DoS vulnerabilities (GHSA-9g9p, GHSA-h25m, GHSA-ggv3, GHSA-3x4c, GHSA-q4gf)
- `postcss` — XSS via unescaped `</style>`

**Fix:** Run `npm audit fix` for non-breaking fixes. For breaking changes, schedule a dependency upgrade sprint.

### M-2: `forbidNonWhitelisted: true` but No DTO Coverage Everywhere (`🟡 MEDIUM`)
**File:** `backend/src/main.ts:75`  
**Issue:** Global validation pipe rejects unknown properties, but some controllers may lack DTOs for all endpoints.  
**Risk:** Unclear which endpoints are fully validated vs. accepting raw objects.  
**Fix:** Audit all controller endpoints to ensure every `@Body()` has a validated DTO.

### M-3: CORS Open in Non-Prod (`🟡 MEDIUM`)
**File:** `backend/src/main.ts:91`  
**Issue:** When `CORS_ORIGINS` is empty and `NODE_ENV !== 'production'`, CORS allows `origin: true` (any origin).  
**Risk:** In a staging environment that looks like prod, this could be exploited.  
**Fix:** Add an explicit `ALLOW_WILDCARD_CORS=true` env flag rather than defaulting open in non-prod.

### M-4: TODO Comments in Production Code (`🟡 MEDIUM`)
**Files:**
- `admin-kyc.controller.ts:25` — `// TODO: get from auth context`
- `kyb.controller.ts:61` — `// TODO: get from auth context`
- `compliance.controller.ts:37` — `// TODO: gate behind admin RBAC`
- `subscriptions.service.ts:120` — `// TODO: Query family_groups table`

**Risk:** TODOs rot. The auth context TODOs are Critical (see C-2). The others are medium.  
**Fix:** Convert to GitHub issues or fix immediately.

---

## 5. Low Issues (P3)

### L-1: Hardcoded Dev Fallback Key (`🟢 LOW`)
**File:** `backend/src/common/crypto/secret-cipher.ts:44`  
**Issue:** Falls back to `'felo-dev-key-NOT-FOR-PRODUCTION-USE'` when env var is missing.  
**Risk:** Only in dev (production check exists), but still a smell.  
**Fix:** Throw an error in production instead of falling back.

### L-2: `NotificationsController` Debug Endpoint (`🟢 LOW`)
**File:** `backend/src/modules/notifications/notifications.controller.ts:53`  
**Issue:** `POST /notifications/in-app` creates notifications but is labeled "debug-only; 403 in production".  
**Risk:** If the 403 guard fails or is bypassed, anyone can spam notifications.  
**Fix:** Remove the endpoint entirely or use a stricter role guard.

---

## 6. Security Strengths (What's Working)

| Feature | Status | Notes |
|---------|--------|-------|
| Helmet.js | ✅ | CSP, HSTS, X-Frame-Options configured |
| Throttler | ✅ | 100/min default, 10/min auth, 5/5min OTP |
| Global Exception Filter | ✅ | RFC 7807 problem details, no stack traces leaked |
| Class-Validator | ✅ | `forbidNonWhitelisted: true` globally |
| JWT Guard | ✅ | Supabase JWKS verification, no shared secret |
| Audit Logging | ✅ | Most services log `ipAddress` + `userAgent` |
| Path Aliases | ✅ | `@/` aliases used consistently |
| Environment Validation | ✅ | `env-validation.ts` checks required vars |

---

## 7. Build & Compilation

| Project | Status | Errors |
|---------|--------|--------|
| Backend | ✅ Pass | 0 TypeScript errors |
| Portal | ✅ Pass | 0 TypeScript errors |

---

## 8. Test Coverage

| Metric | Value |
|--------|-------|
| Test suites | 19 |
| Passing | 0 |
| Failing | 19 (all empty — no tests defined) |
| Coverage | ~0% |

---

## 9. Dependency Audit Summary

### Backend (28 vulns)
| Severity | Count | Examples |
|----------|-------|----------|
| High | 7 | multer, picomatch, webpack |
| Moderate | 17 | Various transitive deps |
| Low | 4 | Minor issues |

### Portal (9 vulns)
| Severity | Count | Examples |
|----------|-------|----------|
| High | 4 | next.js DoS |
| Moderate | 5 | postcss XSS, glob CLI injection |

---

## 10. Recommended Action Plan

### Immediate (This Sprint)
1. **Remove dev bypass** from portal login (`C-1`)
2. **Fix hardcoded reviewerId** in admin KYC/KYB (`C-2`)
3. **Implement UsersModule** with service + controller (`H-1`)

### Next Sprint (Pre-Launch)
4. **Write real tests** or remove empty stubs (`H-2`)
5. **Run `npm audit fix`** on backend and portal (`M-1`)
6. **Resolve all TODOs** or convert to issues (`M-4`)
7. **CORS hardening** for staging environments (`M-3`)

### Post-Launch
8. **Dependency upgrade sprint** for breaking-change fixes
9. **Full DTO audit** across all controllers (`M-2`)
10. **Remove or harden** debug notification endpoint (`L-2`)

---

*Report generated by felo ceo cg — 2026-05-03*
