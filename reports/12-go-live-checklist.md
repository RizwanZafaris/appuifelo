# Felo App — Go-Live Checklist
**Date:** 2026-05-02
**Status:** In Progress

---

## 1. Pre-Launch (T-7 Days)

### Security
- [ ] Rate limiting implemented and tested
- [ ] Input validation on all endpoints
- [ ] Admin JWT auth + MFA deployed
- [ ] Security headers (Helmet) active
- [ ] CORS restricted to known origins
- [ ] PII redaction in logs
- [ ] Webhook signature validation
- [ ] Dependency audit clean (`npm audit`)
- [ ] Penetration test completed (or scheduled)
- [ ] Security runbook documented

### Reliability
- [ ] Retry logic with backoff for remittance
- [ ] Circuit breaker implemented
- [ ] Graceful shutdown handler
- [ ] Request ID propagation
- [ ] Error handling (no raw errors to users)
- [ ] Timeout configuration reviewed
- [ ] Health checks comprehensive
- [ ] Database connection pooling configured

### Testing
- [ ] Backend unit tests > 50% coverage
- [ ] Portal E2E tests passing
- [ ] Remittance provider tests passing
- [ ] Auth flow tested end-to-end
- [ ] Load test completed (target: 1000 concurrent users)
- [ ] Security test (OWASP ZAP) clean
- [ ] Mobile app tested on iOS + Android
- [ ] Offline mode tested (if applicable)

### Infrastructure
- [ ] Production environment provisioned
- [ ] Database migrated and seeded
- [ ] SSL certificates installed
- [ ] DNS configured
- [ ] CDN configured
- [ ] Monitoring dashboards live
- [ ] Alerting configured
- [ ] Backup strategy tested
- [ ] Failover tested (if applicable)
- [ ] Load balancer configured

### Compliance
- [ ] Privacy policy live
- [ ] Terms of service live
- [ ] Cookie consent implemented
- [ ] GDPR data export tested
- [ ] KYC integration ready (or documented as post-launch)
- [ ] AML screening ready (or documented)
- [ ] Data retention policy documented
- [ ] Regulatory review completed

---

## 2. Launch Day (T-0)

### Morning (08:00)
- [ ] Final deployment to production
- [ ] Health check passes
- [ ] Smoke tests pass
- [ ] Monitoring dashboards checked
- [ ] Support team briefed
- [ ] Status page updated ("All systems operational")

### Launch (10:00)
- [ ] App store submissions approved
- [ ] Landing page live
- [ ] Marketing campaign activated
- [ ] Social media posts scheduled
- [ ] Press release distributed

### Monitoring (Continuous)
- [ ] Error rate < 0.1%
- [ ] API latency < 200ms (p95)
- [ ] Signup flow working
- [ ] Login flow working
- [ ] OTP delivery working
- [ ] Remittance initiation working
- [ ] Provider status all green
- [ ] SMS delivery > 95%
- [ ] Support queue manageable

### Communication
- [ ] Team Slack channel active
- [ ] War room open (Zoom bridge)
- [ ] On-call engineer identified
- [ ] Escalation path confirmed

---

## 3. Post-Launch (T+1 to T+7)

### Day 1
- [ ] User feedback collected
- [ ] Error logs reviewed
- [ ] Performance metrics reviewed
- [ ] Support tickets triaged
- [ ] Social media monitored
- [ ] App store reviews monitored

### Day 3
- [ ] First cohort analysis
- [ ] Signup funnel reviewed
- [ ] Drop-off points identified
- [ ] Feature usage breakdown
- [ ] Remittance success rate
- [ ] SMS delivery rate

### Day 7
- [ ] Weekly retrospective
- [ ] Metrics report to leadership
- [ ] P1 backlog prioritized
- [ ] User feedback synthesized
- [ ] Bug fixes deployed
- [ ] Performance optimizations deployed

---

## 4. Rollback Criteria

### Automatic Rollback Triggers
| Metric | Threshold | Action |
|--------|-----------|--------|
| Error rate | > 5% for 5 minutes | Rollback |
| API latency | > 2s for 10 minutes | Rollback |
| Signup failure | > 50% for 5 minutes | Rollback |
| Remittance failure | > 20% for 10 minutes | Rollback |
| Database errors | > 10/minute | Rollback |

### Manual Rollback Decision
- Significant user complaints
- Security incident
- Regulatory concern
- Data integrity issue

### Rollback Procedure
1. Stop deployment pipeline
2. Revert to last known good version
3. Verify health checks pass
4. Monitor for 30 minutes
5. Communicate to users (if needed)
6. Document incident
7. Schedule post-mortem

---

## 5. Success Metrics (30 Days Post-Launch)

| Metric | Target | Measurement |
|--------|--------|-------------|
| Daily Active Users | 100+ | Analytics |
| Signup conversion | > 50% | Funnel |
| Remittance volume | $10K+ | Transactions |
| App store rating | > 4.0 | Reviews |
| Support tickets | < 50/day | Zendesk |
| Error rate | < 0.1% | Monitoring |
| API uptime | > 99.5% | Uptime |
| NPS score | > 30 | Survey |

---

*Go-Live Checklist — Felo Engineering War Room — 2026-05-02*
