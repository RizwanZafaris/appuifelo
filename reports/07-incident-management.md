# Felo App — Incident Management Framework
**Date:** 2026-05-02
**Scope:** Detection, Alerting, Escalation, Response, Post-Incident

---

## 1. Severity Definitions

### SEV1 — Critical (App Unavailable / Major Data Risk)
**Response Time:** 5 minutes  
**Resolution Target:** 1 hour  
**Escalation:** CEO, CTO, CPO immediately

**Examples:**
- App completely down (all users affected)
- Database corruption or data loss
- Security breach (unauthorized data access)
- Payment system failure (all transactions failing)
- Regulatory compliance violation

### SEV2 — Major (Feature Outage)
**Response Time:** 15 minutes  
**Resolution Target:** 4 hours  
**Escalation:** Engineering Lead, Product Lead

**Examples:**
- Remittance system down
- Auth system failure (users can't log in)
- Admin portal down
- Major data sync issues
- API rate limiting affecting all users

### SEV3 — Partial (Degradation)
**Response Time:** 30 minutes  
**Resolution Target:** 8 hours  
**Escalation:** On-call engineer

**Examples:**
- Single remittance provider down
- Slow API responses (> 2s)
- SMS delivery issues
- Analytics pipeline backed up
- Specific feature broken

### SEV4 — Minor (Low Impact)
**Response Time:** 2 hours  
**Resolution Target:** 24 hours  
**Escalation:** None (auto-assigned)

**Examples:**
- Minor UI bug
- Non-critical feature broken
- Documentation issue
- Slow report generation
- Cosmetic issue

---

## 2. Incident Lifecycle

```
┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐
│ DETECT   │ → │ RESPOND  │ → │ RESOLVE  │ → │ REVIEW   │ → │ DOCUMENT │
└──────────┘   └──────────┘   └──────────┘   └──────────┘   └──────────┘
     │              │              │              │              │
     ▼              ▼              ▼              ▼              ▼
  Alert        Triage        Fix          Post-mortem   Update
  Trigger      Assign        Deploy       Meeting       Runbooks
  (Auto)       Engineer      Verify       Write         Share
```

### 2.1 Detection
| Method | Auto/Manual | Coverage |
|--------|-------------|----------|
| Monitoring alerts | Auto | Infrastructure, API health |
| Error rate spike | Auto | Application errors |
| User reports | Manual | Feature-specific issues |
| Support tickets | Manual | User-facing problems |
| Security scans | Auto | Vulnerabilities |
| Compliance checks | Auto | Regulatory issues |

### 2.2 Response
1. **Acknowledge** — On-call engineer acknowledges within SLA
2. **Assess** — Determine severity and impact
3. **Communicate** — Notify stakeholders
4. **Investigate** — Gather logs, metrics, traces
5. **Mitigate** — Apply workaround or rollback
6. **Fix** — Deploy permanent fix
7. **Verify** — Confirm resolution

### 2.3 Communication Matrix
| Severity | Internal | Users | Leadership | Regulators |
|----------|----------|-------|------------|------------|
| SEV1 | Slack + Zoom | Status page | Immediate call | If required |
| SEV2 | Slack | Status page | Slack update | If required |
| SEV3 | Slack | None | Daily digest | None |
| SEV4 | Ticket | None | None | None |

---

## 3. Escalation Matrix

### 3.1 Primary On-Call
**Rotation:** Weekly rotation among backend engineers  
**Hours:** 24/7 for SEV1/SEV2, business hours for SEV3/SEV4  
**Contact:** PagerDuty → Phone + SMS + Slack

### 3.2 Escalation Path
```
SEV1/SEV2:
  0 min → Primary on-call
  5 min → Secondary on-call (if no ack)
  10 min → Engineering Lead
  15 min → CTO
  20 min → CEO (if customer-facing)

SEV3:
  0 min → Primary on-call
  30 min → Secondary on-call
  60 min → Engineering Lead

SEV4:
  0 min → Auto-assigned to team
  24h → Engineering Lead (if not resolved)
```

### 3.3 War Room Protocol (SEV1 only)
1. Create Zoom bridge (auto-generated link in alert)
2. Invite all on-call engineers + leads
3. Designate Incident Commander (IC)
4. Designate Scribe (notes in shared doc)
5. Designate Communication Lead (status updates)
6. IC makes all go/no-go decisions
7. No blame culture — focus on fix

---

## 4. Incident Response Runbooks

### 4.1 Database Down
```
1. Check RDS/Supabase status page
2. Check connection pool exhaustion
3. Check recent deployments (rollback?)
4. Check disk space
5. If primary down → promote read replica
6. If data corruption → restore from backup
7. Document recovery time
```

### 4.2 API Down (High Error Rate)
```
1. Check recent deployments (rollback?)
2. Check external API dependencies (circuit breaker?)
3. Check database connections
4. Check memory/CPU usage
5. Scale up instances if needed
6. Enable feature flags to disable problematic features
7. Document root cause
```

### 4.3 Security Incident
```
1. Isolate affected systems
2. Preserve evidence (logs, snapshots)
3. Notify Security Lead immediately
4. Assess data exposure scope
5. Reset affected credentials
6. Notify users if PII exposed
7. Notify regulators if required (72h GDPR)
8. Conduct forensic analysis
9. Implement preventive measures
```

### 4.4 Remittance Provider Down
```
1. Check provider status page/API
2. Enable failover to backup provider
3. Queue failed transactions for retry
4. Notify affected users
5. Escalate to provider support
6. Monitor recovery
7. Re-process queued transactions
```

### 4.5 SMS Route Failure
```
1. Check route health (auto-failover exists)
2. If all routes fail → notify users via push/email
3. Contact SMS provider support
4. Monitor delivery rates
5. Update route status in admin portal
```

---

## 5. SLA/SLO Tracking

### 5.1 Service Level Objectives
| Service | Availability | Latency (p95) | Error Rate |
|---------|-------------|----------------|------------|
| API | 99.9% | < 200ms | < 0.1% |
| Auth | 99.95% | < 100ms | < 0.01% |
| Remittance | 99.5% | < 5s | < 2% |
| SMS | 99.0% | < 10s | < 5% |
| Notifications | 99.0% | < 2s | < 1% |
| Admin Portal | 99.5% | < 500ms | < 0.1% |

### 5.2 Error Budget
- Monthly error budget: 0.1% (43 minutes downtime)
- If exceeded → freeze non-critical deployments
- If exceeded 2x → all deployments frozen, focus on reliability

---

## 6. Post-Incident Review

### 6.1 Timeline (within 24h of resolution)
1. **What happened?** — Factual timeline
2. **Why did it happen?** — Root cause analysis (5 Whys)
3. **How did we respond?** — Response assessment
4. **What went well?** — Positive aspects
5. **What could be better?** — Improvement areas
6. **What will we do?** — Action items with owners

### 6.2 Template
```markdown
# Post-Incident Review: [INCIDENT-XXX]

## Summary
- Severity: [SEV1/SEV2/SEV3/SEV4]
- Duration: [X minutes]
- Impact: [X users affected, $X revenue impact]
- Root Cause: [Brief description]

## Timeline
- 10:00 — Alert triggered
- 10:05 — On-call acknowledged
- 10:15 — Issue identified
- 10:30 — Workaround applied
- 11:00 — Issue resolved
- 11:30 — Monitoring confirms stability

## Root Cause
[Detailed explanation]

## Impact Assessment
- Users affected: [X]
- Revenue impact: [$X]
- Data impact: [None/Partial/Full]
- Reputational impact: [Low/Medium/High]

## Response Assessment
### What went well
1. [Positive 1]
2. [Positive 2]

### What could be better
1. [Improvement 1]
2. [Improvement 2]

## Action Items
| # | Action | Owner | Due Date | Priority |
|---|--------|-------|----------|----------|
| 1 | [Action] | [Name] | [Date] | P0/P1/P2 |

## Lessons Learned
[Key insights]
```

### 6.3 Action Item Tracking
- All action items tracked in project management tool
- Weekly review of open action items
- Escalate if overdue
- Close only after verification

---

## 7. Incident Dashboard

### 7.1 Metrics to Track
| Metric | Target | Alert |
|--------|--------|-------|
| Mean Time To Detect (MTTD) | < 5 min | > 10 min |
| Mean Time To Acknowledge (MTTA) | < 5 min | > 15 min |
| Mean Time To Resolve (MTTR) | SEV1: < 1h | > 2h |
| Incident recurrence rate | < 10% | > 20% |
| Post-incident completion rate | 100% | < 90% |

---

## 8. Tools

| Purpose | Tool | Status |
|---------|------|--------|
| Alerting | PagerDuty | 🔴 Needed |
| Monitoring | Grafana + Prometheus | 🟡 Planned |
| Logging | Loki | 🟡 Planned |
| Tracing | Tempo (OpenTelemetry) | 🟡 Planned |
| Incident Tracking | PagerDuty or Jira | 🔴 Needed |
| Status Page | Statuspage.io | 🔴 Needed |
| Communication | Slack | ✅ Implemented |
| Video Bridge | Zoom | ✅ Available |
| Documentation | Notion/Confluence | 🟡 Needed |

---

*Incident Management Framework — Felo Engineering War Room — 2026-05-02*
