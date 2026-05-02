# Felo App — Observability & Analytics Plan
**Date:** 2026-05-02
**Scope:** Metrics, Logging, Tracing, Alerting, Dashboards

---

## 1. Current State

### 1.1 Existing Observability
| Component | Status | Notes |
|-----------|--------|-------|
| Health checks | ✅ Basic | Liveness only |
| Logging | 🟡 Console | Unstructured, no correlation IDs |
| Analytics events | ✅ Multi-sink | Postgres + GTM + Meta CAPI |
| Error tracking | ❌ None | No Sentry/Datadog |
| Performance metrics | ❌ None | No Prometheus/Grafana |
| Distributed tracing | ❌ None | No OpenTelemetry |
| Alerting | ❌ None | No PagerDuty/Opsgenie |

---

## 2. Target Architecture

```
┌─────────────────────────────────────────────┐
│              Felo App (Backend)               │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐   │
│  │  Metrics │ │   Logs   │ │  Traces  │   │
│  │Prometheus│ │  Loki    │ │  Tempo   │   │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘   │
└───────┼────────────┼────────────┼──────────┘
        │            │            │
        ▼            ▼            ▼
┌─────────────────────────────────────────────┐
│              Grafana (Unified UI)             │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐   │
│  │Dashboards│ │   Logs   │ │  Traces  │   │
│  │  Alerts  │ │ Explorer │ │ Explorer │   │
│  └──────────┘ └──────────┘ └──────────┘   │
└─────────────────────────────────────────────┘
        │
        ▼
┌─────────────────────────────────────────────┐
│              Alerting Pipeline                │
│     PagerDuty / Opsgenie / Slack / Email    │
└─────────────────────────────────────────────┘
```

---

## 3. Metrics (Prometheus)

### 3.1 Application Metrics
```
# API metrics
http_requests_total{method, path, status}
http_request_duration_seconds{method, path, status}
http_request_size_bytes{method, path}
http_response_size_bytes{method, path}

# Business metrics
active_users_total{corridor, tier}
signups_total{corridor, source}
logins_total{status}
otp_attempts_total{status}
goals_created_total{corridor}
budgets_created_total{corridor}
transactions_total{source, category}
remittances_total{provider, status, corridor}
remittance_amount_total{provider, currency}
reports_downloaded_total{report_type, tier}
subscription_changes_total{from_tier, to_tier}

# External API metrics
provider_requests_total{provider, endpoint, status}
provider_request_duration_seconds{provider, endpoint}
provider_errors_total{provider, error_type}
sms_sent_total{route, status}
sms_delivery_time_seconds{route}

# Infrastructure metrics
db_connections_active
db_connections_idle
db_query_duration_seconds{query_type}
cache_hits_total{cache_name}
cache_misses_total{cache_name}
queue_depth{queue_name}
queue_processing_duration_seconds{queue_name}
```

### 3.2 SLIs and SLOs
| SLI | Target | Alert Threshold |
|-----|--------|-----------------|
| API availability | 99.9% | < 99.5% |
| API latency (p95) | < 200ms | > 500ms |
| Error rate | < 0.1% | > 0.5% |
| DB query latency (p95) | < 50ms | > 100ms |
| SMS delivery rate | > 95% | < 90% |
| Remittance success rate | > 98% | < 95% |

---

## 4. Logging (Loki/Structured)

### 4.1 Log Format (JSON)
```json
{
  "timestamp": "2026-05-02T10:30:00Z",
  "level": "info",
  "service": "felo-api",
  "version": "1.2.3",
  "environment": "production",
  "trace_id": "abc123",
  "span_id": "def456",
  "request_id": "req789",
  "user_id": "user123",
  "correlation_id": "corr456",
  "event": "remittance_initiated",
  "message": "Remittance initiated successfully",
  "context": {
    "provider": "paymob",
    "amount_minor": 100000,
    "currency": "PKR",
    "recipient_country": "PK"
  },
  "metadata": {
    "duration_ms": 245,
    "status_code": 200
  }
}
```

### 4.2 Log Levels by Environment
| Level | Development | Staging | Production |
|-------|-------------|---------|------------|
| debug | ✅ | ✅ | ❌ |
| info | ✅ | ✅ | ✅ |
| warn | ✅ | ✅ | ✅ |
| error | ✅ | ✅ | ✅ |
| security | ✅ | ✅ | ✅ |

### 4.3 Security Event Logging
```
security.auth.success{user_id, ip, user_agent, method}
security.auth.failure{user_id, ip, user_agent, reason}
security.auth.logout{user_id, ip}
security.access.denied{user_id, resource, action, reason}
security.pii.access{admin_id, user_id, fields, reason}
security.config.change{admin_id, key, old_value, new_value}
security.data.export{admin_id, user_id, format}
security.rate_limit.triggered{ip, endpoint, limit}
```

---

## 5. Distributed Tracing (OpenTelemetry)

### 5.1 Trace Structure
```
Trace: remittance_flow
├── Span: api_gateway (2ms)
│   ├── Span: auth_middleware (1ms)
│   ├── Span: rate_limiter (0ms)
│   └── Span: remittance_controller (240ms)
│       ├── Span: validation (5ms)
│       ├── Span: fx_rate_lookup (15ms)
│       │   └── Span: cache_check (2ms)
│       │   └── Span: db_query (10ms)
│       ├── Span: provider_selection (3ms)
│       ├── Span: provider_api_call (200ms)
│       │   ├── Span: dns_lookup (5ms)
│       │   ├── Span: tls_handshake (15ms)
│       │   ├── Span: request_send (5ms)
│       │   └── Span: response_parse (10ms)
│       ├── Span: db_transaction_save (10ms)
│       ├── Span: notification_send (5ms)
│       └── Span: analytics_event (2ms)
```

### 5.2 Instrumentation Points
- HTTP requests (auto)
- Database queries (Drizzle)
- External API calls (Axios)
- Cache operations (Redis)
- Queue jobs (Bull)
- Auth operations
- File uploads

---

## 6. Alerting Rules

### 6.1 Critical Alerts (Page Immediately)
| Alert | Condition | Channel |
|-------|-----------|---------|
| API Down | Error rate > 10% for 2min | PagerDuty |
| DB Down | Connection failures > 5/min | PagerDuty |
| Auth Failure Spike | Login failures > 100/min | PagerDuty |
| Remittance Failure | Success rate < 80% | PagerDuty |
| SMS Failure | Delivery rate < 50% | PagerDuty |
| Data Loss | Unacknowledged messages > 100 | PagerDuty |

### 6.2 Warning Alerts (Notify, Page if Sustained)
| Alert | Condition | Channel |
|-------|-----------|---------|
| High Error Rate | Error rate > 1% for 5min | Slack |
| High Latency | p95 latency > 500ms for 5min | Slack |
| DB Slow Queries | Query time > 100ms | Slack |
| Low Cache Hit | Cache hit rate < 80% | Slack |
| Queue Backup | Queue depth > 1000 | Slack |
| Disk Space | Usage > 80% | Slack |
| Memory Usage | Usage > 80% | Slack |
| Certificate Expiry | < 30 days | Email |

### 6.3 Info Alerts (Dashboard Only)
| Alert | Condition |
|-------|-----------|
| Deployment | New version deployed |
| Config Change | Feature flag toggled |
| User Milestone | 1000 new signups |
| Revenue Milestone | $10K processed |

---

## 7. Dashboards

### 7.1 Product Team Dashboard
- Daily/weekly active users
- Signup funnel
- Feature usage breakdown
- Goal completion rates
- Budget adherence
- Remittance volume by corridor
- User retention cohorts
- NPS/CSAT scores

### 7.2 Tech Team Dashboard
- API latency (p50, p95, p99)
- Error rate by endpoint
- Database performance
- Cache hit rates
- External API health
- Queue depths
- Deployment history
- Incident timeline

### 7.3 Support Team Dashboard
- Open tickets by category
- Average resolution time
- User complaints by type
- Common error messages
- Feature request backlog
- User satisfaction scores

### 7.4 Leadership Dashboard
- Monthly revenue
- User growth
- Remittance volume
- Subscription churn
- Cost per transaction
- Customer acquisition cost
- Lifetime value

### 7.5 Incident Team Dashboard
- Active incidents
- System health (all services)
- Alert history
- Error spikes
- Provider status
- Recovery metrics
- Post-incident reviews

---

## 8. Implementation Plan

### Phase 1 (Week 1-2): Foundation
- [ ] Add correlation ID middleware
- [ ] Implement structured logging
- [ ] Add Prometheus metrics endpoint
- [ ] Set up Grafana instance
- [ ] Create basic dashboards

### Phase 2 (Week 3-4): Tracing & Alerting
- [ ] Add OpenTelemetry instrumentation
- [ ] Set up Tempo/Jaeger
- [ ] Configure alert rules
- [ ] Integrate PagerDuty
- [ ] Test alert pipeline

### Phase 3 (Week 5-6): Advanced
- [ ] Add business metrics
- [ ] Create product dashboards
- [ ] Add security event logging
- [ ] Implement log-based alerts
- [ ] Add anomaly detection

### Phase 4 (Week 7-8): Polish
- [ ] Optimize dashboard performance
- [ ] Add drill-down capabilities
- [ ] Create runbooks for alerts
- [ ] Train team on observability tools
- [ ] Document alerting procedures

---

*Observability & Analytics Plan — Felo Engineering War Room — 2026-05-02*
