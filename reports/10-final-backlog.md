# Felo App — Final Product Improvement Backlog
**Date:** 2026-05-02
**Status:** Prioritized by impact/effort

---

## P0 — Critical (Pre-Launch Blockers)

### Security
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 1 | Implement rate limiting (throttler) | 1d | Backend |
| 2 | Add input validation to all endpoints | 2d | Backend |
| 3 | Replace admin SHA256 with JWT + refresh | 2d | Backend |
| 4 | Add admin MFA (TOTP) | 1d | Backend |
| 5 | Add Helmet security headers | 0.5d | Backend |
| 6 | Restrict CORS origins | 0.5d | Backend |
| 7 | Redact PII from logs | 1d | Backend |
| 8 | Add webhook signature validation | 1d | Backend |

### Reliability
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 9 | Add retry logic with backoff (remittance) | 2d | Backend |
| 10 | Implement circuit breaker | 2d | Backend |
| 11 | Add graceful shutdown handler | 0.5d | Backend |
| 12 | Add request ID propagation | 1d | Backend |
| 13 | Replace raw errors with user-friendly messages | 2d | Backend+Frontend |

### Trust
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 14 | Generate remittance receipt PDF | 2d | Backend |
| 15 | Add real-time status WebSocket | 3d | Backend |
| 16 | Display fee breakdown before confirm | 1d | Frontend |
| 17 | Add provider SLA/ETA display | 0.5d | Frontend |
| 18 | Send confirmation SMS on completion | 1d | Backend |

---

## P1 — High (Month 1)

### Observability
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 19 | Add structured logging with correlation IDs | 2d | Backend |
| 20 | Add Prometheus metrics endpoint | 2d | Backend |
| 21 | Set up Grafana dashboards | 3d | DevOps |
| 22 | Add OpenTelemetry tracing | 3d | Backend |
| 23 | Configure PagerDuty alerts | 1d | DevOps |

### Admin Portal
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 24 | Build incident dashboard | 3d | Frontend |
| 25 | Build support ticket view | 3d | Frontend+Backend |
| 26 | Add config management UI | 2d | Frontend |
| 27 | Add real-time user activity stream | 2d | Backend+Frontend |
| 28 | Add bulk operations | 2d | Backend+Frontend |

### Testing
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 29 | Add backend unit tests (target 50%) | 5d | Backend |
| 30 | Add portal E2E tests | 3d | Frontend |
| 31 | Add security tests (OWASP ZAP) | 2d | QA |
| 32 | Add load tests (k6/Artillery) | 2d | QA |

### UX
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 33 | Simplify onboarding (progress bar) | 1d | Frontend |
| 34 | Add income vs expense chart | 1d | Frontend |
| 35 | Add net worth tracking | 2d | Backend+Frontend |
| 36 | Add rate alerts | 2d | Backend+Frontend |
| 37 | Add recurring remittance | 3d | Backend+Frontend |
| 38 | Add budget templates | 1d | Frontend |

---

## P2 — Medium (Month 2-3)

### Features
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 39 | Family sharing / joint goals | 5d | Backend+Frontend |
| 40 | Bill reminders | 2d | Backend+Frontend |
| 41 | Tax reports (T4/T4A for Canada) | 3d | Backend |
| 42 | Spending insights (AI-generated) | 3d | Backend |
| 43 | Investment tracking improvements | 2d | Frontend |
| 44 | Multi-currency budgets | 2d | Backend |

### Infrastructure
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 45 | Add Redis caching layer | 2d | DevOps |
| 46 | Add read replicas for analytics | 3d | DevOps |
| 47 | Implement message queues (Bull/Redis) | 3d | Backend |
| 48 | Add database partitioning | 3d | Backend |
| 49 | Add CDN for static assets | 1d | DevOps |

### Compliance
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 50 | Integrate Sumsub (KYC) | 5d | Backend |
| 51 | Integrate ComplyAdvantage (AML) | 3d | Backend |
| 52 | Add GDPR data retention policies | 2d | Backend |
| 53 | Add automated data export | 2d | Backend |
| 54 | Add audit log tamper detection | 2d | Backend |

---

## P3 — Future Roadmap (Q2+)

### Growth
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 55 | A/B testing framework | 5d | Frontend+Backend |
| 56 | Advanced referral system | 3d | Backend |
| 57 | Merchant rewards program | 5d | Backend+Frontend |
| 58 | In-app marketplace | 8d | Full team |

### Expansion
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 59 | Multi-region deployment | 5d | DevOps |
| 60 | EU market (GDPR compliance) | 5d | Compliance |
| 61 | Bank aggregation (Plaid) | 5d | Backend |
| 62 | Card issuing (Stripe Issuing) | 8d | Backend |

### Advanced
| # | Item | Effort | Owner |
|---|------|--------|-------|
| 63 | AI financial advisor (advanced) | 10d | Backend+ML |
| 64 | Predictive budgeting | 5d | Backend |
| 65 | Fraud detection ML | 8d | Backend+ML |
| 66 | Credit scoring | 10d | Backend+Compliance |

---

## Backlog Statistics

| Priority | Items | Total Effort | % of Total |
|----------|-------|-------------|------------|
| P0 | 18 | ~17 days | 15% |
| P1 | 20 | ~35 days | 30% |
| P2 | 16 | ~40 days | 35% |
| P3 | 12 | ~51 days | 20% |
| **Total** | **66** | **~143 days** | **100%** |

**Team Velocity Assumption:** 5 engineers × 5 days/week × 0.7 efficiency = ~17 story points/week

**Timeline:**
- P0: ~1 week (with 5 engineers)
- P1: ~2 weeks
- P2: ~2-3 weeks
- P3: ~3-4 weeks (Q2)

---

*Final Product Improvement Backlog — Felo Engineering War Room — 2026-05-02*
