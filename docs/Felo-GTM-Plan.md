# Felo Go-To-Market (GTM) Plan
## Comprehensive Launch Strategy & Revenue Roadmap

---

## Executive Summary

**Product**: Felo — Cross-border remittance platform for South Asian corridors (UAE→PK, KSA→BD, etc.) with 18+ provider integrations, instant KYC, and competitive FX rates.

**Budget**: $100/month (bootstrap phase)
**Launch Timeline**: Beta → 5 users in 2 days → 100 users by Month 3 → 1,000 users by Month 6

---

## 1. Product Readiness Status

### What Works (Ready for Users)
| Feature | Status | Notes |
|---------|--------|-------|
| User registration & auth | ✅ | JWT + OTP |
| KYC verification | ✅ | Sumsub integration, 24-48hr turnaround |
| Send money (18 providers) | ✅ | AE-PK, SA-BD, UAE-NP corridors |
| Wallet/balance | ✅ | Deposit, hold, send |
| Transaction tracking | ✅ | Real-time status + QR receipt |
| SMS notifications | ✅ | 4-route failover (99.9% delivery) |
| Admin portal | ✅ | Incidents, support tickets, system health |
| Security & compliance | ✅ | Rate limiting, audit logs, GDPR, data retention |
| Unit tests | ✅ | 80%+ coverage on critical paths |

### Pre-Launch Checklist (Operations Team)
- [ ] **Provider credentials** — All 18 providers have live (not sandbox) API keys
- [ ] **FX rate feeds** — Real-time rate source connected (XE, OANDA, or provider direct)
- [ ] **Compliance review** — Local remittance license confirmed for target markets
- [ ] **Bank settlement accounts** — Nostro accounts for PKR, BDT, NPR receiving
- [ ] **Customer support** — WhatsApp Business API number + auto-responses configured
- [ ] **Refund policy** — Documented and displayed in-app
- [ ] **Terms of service** — Reviewed by legal counsel
- [ ] **Error monitoring** — Sentry/LogRocket configured for production
- [ ] **Uptime monitoring** — Pingdom or UptimeRobot on all critical endpoints
- [ ] **Disaster recovery** — Database backups tested, runbook documented
- [ ] **Load testing** — 100 concurrent users simulated
- [ ] **Payment reconciliation** — Daily auto-reconciliation job verified
- [ ] **Chargeback handling** — Process documented with provider SLAs

---

## 2. Marketing Plan ($100/Month Budget)

### Budget Allocation ($100)
| Activity | Cost | Why |
|----------|------|-----|
| Canva Pro (design) | $13 | Social posts, flyers, pitch decks |
| WhatsApp Business API | $15 | Bulk messaging to community groups |
| Domain + hosting (blog) | $10 | SEO content hub |
| Micro-influencer (1x) | $40 | Single diaspora community influencer post |
| Facebook/IG boosted post | $12 | Geo-targeted to Pakistani/Bangladeshi diaspora |
| Contingency | $10 | A/B testing small creatives |

### Strategy: "Community-First Guerrilla Launch"

With $100, we cannot compete on paid acquisition. We win through **trust density** in tight-knit diaspora communities.

#### Phase 1: Beta (Weeks 1-2) — "The Inner Circle"
**Goal**: 5 active senders, 10+ recipients

**Tactics (Cost: $0)**
1. **Founder's personal network** — CEO sends to 50 friends/family personally via WhatsApp
2. **Mosque/Community center flyers** — Print 100 A5 flyers ($0 if printed at home/office)
3. **WhatsApp group seeding** — Join 20 Pakistani/Bangladeshi worker groups, share value (not ads)
4. **Referral hook**: "Send your first transfer free + recipient gets bonus Rs. 500"

**Messaging**: *"Built by people who send money home. No hidden fees. Real exchange rates."*

#### Phase 2: Growth (Weeks 3-8) — "The Trust Loop"
**Goal**: 100 users, $50K monthly volume

**Tactics**
1. **Referral program** (product feature): Give both sender + recipient $5 credit
2. **Community ambassador** (1 person per city): Free transfers for life in exchange for onboarding 20 users/month
3. **Content marketing** (blog): "How to avoid remittance scams" — SEO gold
4. **TikTok/Reels** (organic): 30-sec videos showing transfer in real-time
5. **Micro-influencer** ($40): One trusted voice in a Dubai/KSA worker community

**KPIs**: 
- Cost per acquisition: $0 (organic/referral)
- Viral coefficient: 1.2 (each user brings 1.2 new users)
- Monthly volume: $50K by Week 8

#### Phase 3: Scale (Months 3-6) — "The Moat"
**Goal**: 1,000 users, $500K monthly volume

**Tactics**
1. **B2B partnerships**: Tie-ups with recruiting agencies, travel agents serving diaspora
2. **Remittance comparison tool** (website widget): Free SEO traffic
3. **WhatsApp status stories**: Daily rates updates (takes 2 min, massive reach)
4. **User-generated content**: "Share your Felo receipt, win free transfer"
5. **PR pitch**: "Fintech built by migrants for migrants" — human interest angle

---

## 3. Revenue Structure

### Revenue Streams

| Stream | Description | Margin | Monthly at Scale |
|--------|-------------|--------|-----------------|
| **FX Spread** | Markup on exchange rate vs. mid-market | 0.5-1.5% | Primary driver |
| **Transaction Fee** | Flat or % fee per send | $1-3 or 0.5% | Secondary |
| **Card Funding** | Interchange when users fund via debit/credit | 1-2% | Small but steady |
| **B2B Remittance** | Bulk payroll for construction/hospitality companies | Negotiated | High value |
| **Float Interest** | Interest on held balances (regulated markets) | Variable | Tertiary |

### Unit Economics (Per $100 Transfer)

| Component | Cost | Revenue | Net |
|-----------|------|---------|-----|
| Provider payout | $98.50 | — | — |
| FX spread (1%) | — | $1.00 | +$1.00 |
| Transaction fee | — | $1.50 | +$1.50 |
| SMS cost | $0.02 | — | -$0.02 |
| KYC verification (amortized) | $0.15 | — | -$0.15 |
| Server/cloud cost (amortized) | $0.10 | — | -$0.10 |
| **Net profit per $100** | — | — | **+$2.23** |

**Take rate: 2.5% | Net margin: 2.23%**

### Monthly Revenue Projections (Conservative)

| Month | Active Users | Avg Txn/User | Monthly Volume | Gross Revenue | Net Profit |
|-------|-------------|--------------|----------------|---------------|------------|
| 1 | 5 | 1x$200 | $1,000 | $25 | $22 |
| 2 | 20 | 2x$250 | $10,000 | $250 | $223 |
| 3 | 100 | 2x$300 | $60,000 | $1,500 | $1,338 |
| 4 | 250 | 2.5x$350 | $218,750 | $5,469 | $4,879 |
| 5 | 500 | 3x$400 | $600,000 | $15,000 | $13,380 |
| 6 | 1,000 | 3x$450 | $1,350,000 | $33,750 | $30,105 |
| 12 | 5,000 | 4x$500 | $10,000,000 | $250,000 | $223,000 |

**Break-even**: Month 3 (revenue covers server + SMS + minimal team)
**Positive cash flow**: Month 4

---

## 4. Month-on-Month Growth Plan

### Month 1: Foundation
- **Product**: Bug-free beta, all providers live
- **Users**: 5 (friends/family)
- **Volume**: $1,000
- **Marketing**: Personal outreach only
- **Ops**: Daily reconciliation, manual support
- **Goal**: Validate transfer flow end-to-end

### Month 2: Validation
- **Product**: Feedback-driven polish, referral feature built
- **Users**: 20 (community seeding)
- **Volume**: $10,000
- **Marketing**: WhatsApp groups, community centers
- **Ops**: Automated receipt emails, basic analytics
- **Goal**: Prove product-market fit with strangers

### Month 3: Traction
- **Product**: App store launch (iOS + Android)
- **Users**: 100
- **Volume**: $60,000
- **Marketing**: Influencer #1, content blog live
- **Ops**: First support hire (part-time), incident response SOPs
- **Goal**: Break-even on operational costs

### Month 4: Acceleration
- **Product**: B2B portal (bulk sends for employers)
- **Users**: 250
- **Volume**: $218,750
- **Marketing**: Referral loop kicks in, comparison widget
- **Ops**: 24/7 support rotation, automated alerts
- **Goal**: Positive unit economics proven

### Month 5: Expansion
- **Product**: New corridor (Nepal, Philippines)
- **Users**: 500
- **Volume**: $600,000
- **Marketing**: PR push, podcast appearances
- **Ops**: Compliance audit, AML review
- **Goal**: Prepare for seed funding pitch

### Month 6: Scale
- **Product**: Savings product (hold PKR/BDT, earn interest)
- **Users**: 1,000
- **Volume**: $1.35M
- **Marketing**: Paid ads test ($500 budget), partnership deals
- **Ops**: Hire head of operations, automate reconciliation
- **Goal**: $30K net profit, ready for Series A conversation

---

## 5. Things You Need to Arrange

### Immediate (This Week)
| Item | Who | Why | Cost |
|------|-----|-----|------|
| Live API keys for all 18 providers | You / CTO | Without these, no money moves | Provider-dependent |
| Business bank accounts (PKR, BDT) | You / CFO | Settlement accounts for receiving funds | $0-500 setup |
| Remittance license / regulatory check | You / Legal | Operating without license = shutdown risk | Legal fees |
| WhatsApp Business API account | Product team | Primary support channel | Free |
| App store developer accounts | Product team | iOS + Android distribution | $100/year |

### Short-Term (Month 1-2)
| Item | Who | Why | Cost |
|------|-----|-----|------|
| Customer support person (part-time) | Operations | Users will have issues | $200-400/mo |
| Error monitoring (Sentry/LogRocket) | CTO | Catch bugs before users do | $26/mo |
| Uptime monitoring | CTO | Know when providers are down | $15/mo |
| SSL certificate + security audit | CTO | Trust signal for users | $50-200 |
| Basic accounting setup | CFO | Track revenue, taxes | $50/mo |

### Growth Phase (Month 3-6)
| Item | Who | Why | Cost |
|------|-----|-----|------|
| Full-time support lead | Operations | Scale support quality | $500-800/mo |
| Compliance officer (part-time) | Legal/COO | AML/KYC requirements | $300-500/mo |
| Seed funding conversation | You | Scale marketing, new corridors | — |
| Additional server capacity | CTO | Handle 1000+ concurrent users | $50-100/mo |

---

## 6. Success Metrics Dashboard

### Weekly Tracking
| Metric | Target W2 | Target M1 | Target M3 | Target M6 |
|--------|-----------|-----------|-----------|-----------|
| Active senders | 5 | 5 | 100 | 1,000 |
| Avg transaction size | $200 | $200 | $300 | $450 |
| Transfers per user/month | 1 | 1 | 2 | 3 |
| Failed transfer rate | <5% | <3% | <2% | <1% |
| Support ticket volume | N/A | <10/week | <20/week | <50/week |
| NPS score | N/A | >30 | >40 | >50 |
| App store rating | N/A | N/A | >4.0 | >4.3 |
| Referral rate | N/A | 10% | 25% | 40% |

---

## 7. Narrative Building (Digital Media)

### Core Story
> *"Felo wasn't built in a boardroom. It was built by people who stand in line at exchange houses every weekend. We know the hidden fees, the slow transfers, the 'your money is stuck' calls. So we built something better — transparent, fast, and fair."*

### Content Pillars
1. **The Human Cost of Remittance** — Stories of workers sending money home
2. **The Fee Exposed** — Comparison posts showing what others charge vs. Felo
3. **Behind the Scenes** — How we keep money safe (security, compliance)
4. **Community Wins** — User testimonials, "I sent my daughter's school fees in 30 seconds"
5. **Market Intelligence** — "Best day to send PKR this week" rate forecasts

### Channels (Organic Priority)
1. **TikTok/Reels** (highest ROI for diaspora workers)
2. **Facebook Groups** (Pakistani/Bangladeshi community groups in UAE/KSA)
3. **WhatsApp Status** (daily rate updates, takes 2 min)
4. **LinkedIn** (B2B angle for employer partnerships)
5. **Blog/SEO** (long-term organic traffic)

---

## Next Steps

**This week (CEO action items)**:
1. Confirm live provider API keys with CTO
2. Open settlement bank accounts in PK and BD
3. Start WhatsApp outreach to 50 personal contacts
4. Print 100 flyers for local community centers
5. Review and approve this GTM plan

**I can help with**:
- Drafting WhatsApp outreach messages
- Creating the comparison tool widget
- Writing the "How to avoid remittance scams" blog post
- Building the referral program logic in the app
- Setting up the metrics dashboard

Let me know which pieces you want me to build first.
