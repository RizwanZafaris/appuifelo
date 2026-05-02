# Felo App — Admin/Officer Portal Requirements
**Date:** 2026-05-02
**Status:** Partial — needs incident dashboard, support view, config management

---

## 1. Current Portal Features

### 1.1 Authentication
- [x] Admin login with token
- [x] Role-based access control
- [x] Permission-based navigation
- [x] Two-person approval workflow

### 1.2 User Management
- [x] User list with search/filter
- [x] User detail view
- [x] PII access logging
- [x] User activity traceability

### 1.3 Remittance Operations
- [x] Provider management (CRUD)
- [x] Route management
- [x] FX rate viewing
- [x] FX rate override (with approval)

### 1.4 Feature Management
- [x] Feature flags (CRUD)
- [x] Kill switches
- [x] Targeted rollouts

### 1.5 Notifications
- [x] Template management
- [x] Banner management
- [x] Campaign sending

### 1.6 Compliance
- [x] PII access logs
- [x] Data retention viewer
- [x] DSR request handling

### 1.7 Analytics
- [x] Dashboard with charts
- [x] User analytics
- [x] Transaction analytics

---

## 2. Missing Features (Priority Order)

### 🔴 P0 — Critical (Pre-Launch)

#### 2.1 Incident Dashboard
**Purpose:** Real-time system health monitoring

**Features:**
- [ ] Error rate chart (last 1h, 24h, 7d)
- [ ] API latency chart by endpoint
- [ ] Failed transaction count
- [ ] Remittance provider status
- [ ] SMS route health
- [ ] Database connection pool status
- [ ] Alert history
- [ ] Active incidents list
- [ ] Incident creation/escalation

**UI:**
```
┌─────────────────────────────────────────┐
│  System Health        Status: 🟢 Healthy │
├─────────────────────────────────────────┤
│  Error Rate     │  API Latency          │
│  ┌─────────┐    │  ┌─────────┐          │
│  │  0.1%   │    │  │  45ms   │          │
│  └─────────┘    │  └─────────┘          │
├─────────────────────────────────────────┤
│  Active Incidents: 0                   │
│  Last Alert: 2 hours ago               │
├─────────────────────────────────────────┤
│  Provider Status                       │
│  ✅ Paymob    ✅ Samsara   ⚠️ Khalti   │
│  ✅ Safepay   ✅ 8B        ✅ HRC       │
│  ✅ HabibMetro ✅ DIGIT9  ✅ MTB      │
└─────────────────────────────────────────┘
```

#### 2.2 Support Ticket View
**Purpose:** View and manage user support requests

**Features:**
- [ ] Ticket list (open, in-progress, resolved)
- [ ] Ticket detail view
- [ ] User context (transactions, profile)
- [ ] Ticket assignment
- [ ] Internal notes
- [ ] Status updates
- [ ] SLA tracking

#### 2.3 Configuration Management
**Purpose:** Change app settings without code deployment

**Features:**
- [ ] Goal limit configuration
- [ ] Budget category management
- [ ] Report pricing (free/paid/limited)
- [ ] Subscription tier limits
- [ ] Coach prompt management
- [ ] SMS parser template editor
- [ ] Country/corridor controls
- [ ] Notification threshold settings

**Example:**
```json
{
  "goals.max_per_user": 2,
  "goals.min_amount_minor": 1000,
  "reports.download.free_monthly": 1,
  "reports.download.paid_monthly": 10,
  "coach.queries.free_daily": 5,
  "coach.queries.plus_daily": 50,
  "sms.parser.enabled_countries": ["PK", "BD"],
  "remittance.max_per_day_minor": 10000000
}
```

### 🟠 P1 — High Priority (Month 1)

#### 2.4 Real-Time User Activity Monitoring
**Purpose:** Monitor active users and suspicious activity

**Features:**
- [ ] Active users count (real-time)
- [ ] Login/logout stream
- [ ] Transaction activity stream
- [ ] Remittance activity stream
- [ ] Suspicious activity alerts
- [ ] Geolocation anomalies
- [ ] Device fingerprint changes

#### 2.5 Bulk Operations
**Purpose:** Efficiently manage large numbers of users

**Features:**
- [ ] Bulk user export
- [ ] Bulk notification send
- [ ] Bulk status update
- [ ] Bulk tier change
- [ ] Bulk feature flag toggle
- [ ] Import from CSV

#### 2.6 Marketing Campaign Analytics
**Purpose:** Track campaign effectiveness

**Features:**
- [ ] Campaign list with metrics
- [ ] Open rate tracking
- [ ] Click-through rate
- [ ] Conversion tracking
- [ ] A/B test results
- [ ] User cohort analysis

#### 2.7 System Health Dashboard
**Purpose:** Infrastructure monitoring for ops team

**Features:**
- [ ] CPU/Memory usage
- [ ] Database metrics
- [ ] API response times
- [ ] Queue depth (if using message queues)
- [ ] External API health
- [ ] Certificate expiry alerts
- [ ] Disk space alerts

### 🟡 P2 — Medium Priority (Month 2-3)

#### 2.8 A/B Test Configuration
**Purpose:** Product experimentation

**Features:**
- [ ] Test creation (name, variants, audience)
- [ ] Audience segmentation
- [ ] Traffic allocation
- [ ] Metrics tracking
- [ ] Statistical significance
- [ ] Test results
- [ ] Auto-winner selection

#### 2.9 Data Export Management
**Purpose:** GDPR compliance and user data portability

**Features:**
- [ ] Export request queue
- [ ] Export progress tracking
- [ ] Download links (time-limited)
- [ ] Deletion request queue
- [ ] Deletion confirmation

#### 2.10 Advanced Audit Viewer
**Purpose:** Comprehensive audit trail

**Features:**
- [ ] Filter by user, action, date
- [ ] Diff view (before/after)
- [ ] Export audit logs
- [ ] Tamper detection
- [ ] Retention policy display

---

## 3. UI/UX Requirements

### 3.1 Responsive Design
- Must work on tablets (primary admin device)
- Should work on mobile (emergency access)
- Minimum 768px width for full experience

### 3.2 Performance
- Page load < 2 seconds
- Table with 1000 rows must not freeze
- Real-time charts update every 5 seconds
- Search/filter < 500ms response

### 3.3 Accessibility
- WCAG 2.1 AA compliance
- Keyboard navigation
- Screen reader support
- High contrast mode

### 3.4 Security
- Session timeout after 30 minutes
- Re-authenticate for sensitive actions
- All admin actions logged
- PII masked by default
- Download audit trail

---

## 4. Role-Based Feature Access

| Feature | Super Admin | Ops Manager | Support Lead | Analyst | Compliance Officer | Billing Admin | Readonly |
|---------|-------------|-------------|--------------|---------|-------------------|---------------|----------|
| Incident Dashboard | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ |
| Support Tickets | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Config Management | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| User Activity | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ |
| Bulk Operations | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Marketing Analytics | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ | ✅ |
| System Health | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ |
| A/B Tests | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ |
| Data Exports | ✅ | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ |
| Advanced Audit | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ |

---

## 5. Implementation Plan

### Phase 1 (Week 1-2): Foundation
- [ ] Incident dashboard backend
- [ ] Incident dashboard frontend
- [ ] Real-time WebSocket connection
- [ ] Basic alert system

### Phase 2 (Week 3-4): Support & Config
- [ ] Support ticket backend
- [ ] Support ticket frontend
- [ ] Config registry expansion
- [ ] Config management UI

### Phase 3 (Week 5-6): Monitoring
- [ ] User activity stream
- [ ] Bulk operations backend
- [ ] Bulk operations UI
- [ ] Marketing campaign analytics

### Phase 4 (Week 7-8): Advanced
- [ ] System health dashboard
- [ ] A/B test framework
- [ ] Data export management
- [ ] Advanced audit viewer

---

## 6. API Endpoints Required

```
GET    /admin/v1/incidents           → List incidents
POST   /admin/v1/incidents           → Create incident
PATCH  /admin/v1/incidents/:id       → Update incident
GET    /admin/v1/health              → System health
GET    /admin/v1/metrics             → Metrics (prometheus format)
GET    /admin/v1/support-tickets     → List tickets
GET    /admin/v1/support-tickets/:id → Ticket detail
PATCH  /admin/v1/support-tickets/:id → Update ticket
GET    /admin/v1/activity-stream     → Real-time activity
GET    /admin/v1/bulk-operations     → List operations
POST   /admin/v1/bulk-operations     → Create operation
GET    /admin/v1/campaigns           → List campaigns
GET    /admin/v1/campaigns/:id       → Campaign detail
GET    /admin/v1/ab-tests            → List A/B tests
POST   /admin/v1/ab-tests            → Create A/B test
GET    /admin/v1/exports             → List exports
POST   /admin/v1/exports             → Create export
```

---

*Admin Portal Requirements — Felo Engineering War Room — 2026-05-02*
