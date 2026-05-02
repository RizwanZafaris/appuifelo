# Felo App — Team-Wise Action Plan
**Date:** 2026-05-02
**Sprints:** 2-week sprints, 5 engineers

---

## Team Structure

| Role | Count | Focus |
|------|-------|-------|
| Backend Engineer | 2 | API, security, integrations |
| Frontend Engineer | 1 | Portal, UX |
| DevOps/SRE | 1 | Infrastructure, observability |
| QA Engineer | 1 | Testing, automation |
| Product Manager | 1 | Requirements, prioritization |
| Designer | 1 (shared) | UX, flows |
| Security Lead | 1 (advisory) | Security review |
| Compliance Officer | 1 (advisory) | Regulatory |

---

## Sprint 1: Security & Reliability (Week 1-2)

### Backend Team (2 engineers)
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 1 | Implement rate limiting | 2d | P0 |
| 2 | Add input validation to all endpoints | 3d | P0 |
| 3 | Replace admin auth with JWT + MFA | 3d | P0 |
| 4 | Add retry logic for remittance | 2d | P0 |
| 5 | Implement circuit breaker | 2d | P0 |

### Frontend Team (1 engineer)
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 6 | Add error boundaries | 2d | P0 |
| 7 | Replace raw errors with user-friendly messages | 2d | P0 |
| 8 | Add loading states/skeleton screens | 2d | P1 |
| 9 | Add fee breakdown UI | 1d | P0 |

### DevOps (1 engineer)
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 10 | Add security headers (Helmet) | 1d | P0 |
| 11 | Restrict CORS | 0.5d | P0 |
| 12 | Set up Grafana + Prometheus | 3d | P1 |
| 13 | Configure alerting (PagerDuty) | 1d | P1 |

### QA (1 engineer)
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 14 | Security tests (OWASP ZAP) | 2d | P0 |
| 15 | Auth flow E2E tests | 2d | P0 |
| 16 | Remittance flow E2E tests | 3d | P0 |

**Sprint 1 Goal:** All P0 security and reliability items closed.

---

## Sprint 2: Observability & Admin (Week 3-4)

### Backend Team
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 17 | Add structured logging | 2d | P1 |
| 18 | Add business metrics | 2d | P1 |
| 19 | Add OpenTelemetry tracing | 3d | P1 |
| 20 | Add graceful shutdown | 1d | P0 |
| 21 | Generate remittance receipts | 2d | P0 |

### Frontend Team
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 22 | Build incident dashboard | 3d | P1 |
| 23 | Build support ticket view | 3d | P1 |
| 24 | Add config management UI | 2d | P1 |
| 25 | Add real-time status UI | 2d | P0 |

### DevOps
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 26 | Set up Loki (log aggregation) | 2d | P1 |
| 27 | Set up Tempo (tracing) | 2d | P1 |
| 28 | Create production dashboards | 2d | P1 |
| 29 | Test backup/restore | 1d | P1 |

### QA
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 30 | Backend unit tests (target 50%) | 5d | P1 |
| 31 | Portal E2E tests | 3d | P1 |
| 32 | Load tests | 2d | P1 |

**Sprint 2 Goal:** Observability stack live + admin portal enhanced.

---

## Sprint 3: UX & Features (Week 5-6)

### Backend Team
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 33 | Add rate alerts backend | 2d | P1 |
| 34 | Add recurring remittance | 3d | P1 |
| 35 | Add net worth calculation | 2d | P1 |
| 36 | Add Redis caching | 2d | P2 |

### Frontend Team
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 37 | Simplify onboarding | 2d | P1 |
| 38 | Add income vs expense chart | 1d | P1 |
| 39 | Add net worth display | 1d | P1 |
| 40 | Add rate alerts UI | 1d | P1 |
| 41 | Add budget templates | 1d | P1 |

### DevOps
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 42 | Add read replicas | 2d | P2 |
| 43 | Add message queues | 2d | P2 |
| 44 | Performance optimization | 2d | P2 |

### QA
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 45 | UX flow testing | 3d | P1 |
| 46 | Accessibility tests | 2d | P1 |
| 47 | Performance tests | 2d | P1 |

**Sprint 3 Goal:** UX polished + key features added.

---

## Sprint 4: Compliance & Hardening (Week 7-8)

### Backend Team
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 48 | Integrate Sumsub (KYC) | 5d | P0 |
| 49 | Integrate ComplyAdvantage (AML) | 3d | P0 |
| 50 | Add data retention policies | 2d | P1 |
| 51 | Add automated data export | 2d | P1 |

### Frontend Team
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 52 | KYC flow UI | 3d | P0 |
| 53 | Data export/download UI | 1d | P1 |
| 54 | Privacy settings page | 1d | P1 |

### DevOps
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 55 | DR testing | 1d | P1 |
| 56 | Security hardening review | 2d | P0 |
| 57 | Penetration test coordination | 1d | P0 |

### QA
| # | Task | Effort | Priority |
|---|------|--------|----------|
| 58 | KYC flow testing | 3d | P0 |
| 59 | Compliance testing | 2d | P0 |
| 60 | End-to-end regression | 3d | P0 |

**Sprint 4 Goal:** Compliance requirements met + hardening complete.

---

## Parallel Workstreams

### Marketing Team (Parallel, all sprints)
| Sprint | Task | Owner |
|--------|------|-------|
| 1-2 | App store assets | Marketing |
| 1-2 | Landing page copy | Marketing |
| 2-3 | Launch email sequence | Marketing |
| 3-4 | Social media content | Marketing |
| 4 | PR outreach | Marketing |

### Product Team (Parallel, all sprints)
| Sprint | Task | Owner |
|--------|------|-------|
| 1 | Feature flag strategy | PM |
| 2 | Analytics requirements | PM |
| 3 | Pricing finalization | PM |
| 4 | Roadmap planning | PM |

### Support Team (Parallel, all sprints)
| Sprint | Task | Owner |
|--------|------|-------|
| 1 | FAQ documentation | Support |
| 2 | Ticket categorization | Support |
| 3 | Escalation matrix | Support |
| 4 | SOP documentation | Support |

---

## Sprint Ceremonies

| Ceremony | Frequency | Duration | Attendees |
|----------|-----------|----------|-----------|
| Sprint Planning | Bi-weekly (Monday) | 2 hours | All |
| Daily Standup | Daily | 15 min | Engineering |
| Sprint Review | Bi-weekly (Friday) | 1 hour | All |
| Retrospective | Bi-weekly (Friday) | 1 hour | Engineering |
| Backlog Refinement | Weekly (Wednesday) | 1 hour | PM + Leads |

---

## Key Milestones

| Milestone | Date | Success Criteria |
|-----------|------|-----------------|
| Security Hardening Complete | Week 2 | All P0 security items closed |
| Observability Live | Week 4 | Grafana dashboards + alerts working |
| UX Polish Complete | Week 6 | Onboarding simplified, trust signals added |
| Compliance Ready | Week 8 | KYC + AML integrated, tests passing |
| **MVP Launch** | **Week 8** | **All go-live checklist items complete** |

---

*Team-Wise Action Plan — Felo Engineering War Room — 2026-05-02*
