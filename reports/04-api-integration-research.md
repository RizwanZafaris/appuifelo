# Felo App — API Integration Research & Recommendations
**Date:** 2026-05-02
**Scope:** Remittance, Payout, KYC, AML, Payments, Wallets, FX, Notifications

---

## 1. Remittance & Payout Providers (IMPLEMENTED: 17)

### 1.1 Live Payout Providers
| # | Provider | Country | Method | Auth | Complexity | Status |
|---|----------|---------|--------|------|------------|--------|
| 1 | Paymob | Egypt | Bank/Wallet | HMAC | Medium | ✅ Live |
| 2 | Samsara | Malaysia | Bank | API Key | Low | ✅ Live |
| 3 | Khalti | Nepal | Wallet | API Key | Low | ✅ Live |
| 4 | Safepay RAAST | Pakistan | Bank/Wallet | API Key | Medium | ✅ Live |
| 5 | 8B | Uzbekistan/Kazakhstan | Bank/Card | HMAC | Medium | ✅ Live |
| 6 | HRC (UBL) | Pakistan | Bank | Token | Medium | ✅ Live |
| 7 | HabibMetro | Pakistan | Bank | OTP+Token | High | ✅ Live |
| 8 | DIGIT9 | Pakistan | Bank | OAuth2 | Medium | ✅ Live |
| 9 | MTB | Bangladesh | Bank | JWT+Basic | High | ✅ Live |
| 10 | Agrani Bank | Bangladesh | Bank | XML+PKCS7 | High | ✅ Live |
| 11 | Brac Bank | Bangladesh | Bank | OAuth2+JWE | Very High | ✅ Live |
| 12 | Prime Bank | Bangladesh | Bank | Token+AES | High | ✅ Live |
| 13 | Standard Bank | Bangladesh | Bank | SOAP+Salt | High | ✅ Live |
| 14 | UCB | Bangladesh | Bank | Session+DLL | Very High | ✅ Live |
| 15 | Dhaka Bank | Bangladesh | Bank | OAuth2 | Medium | ✅ Live |
| 16 | ABL | Pakistan | Bank | SOAP | High | ✅ Live |
| 17 | Faysal Bank | Pakistan | Bank | MD5 Token | High | ✅ Live |

---

## 2. Recommended Future Integrations

### 2.1 PAYIN Providers (Card/Wallet Collection)
| Provider | Region | Use Case | Complexity | Regulation | MVP? |
|----------|--------|----------|------------|------------|------|
| **Stripe** | Global | Card processing | Medium | PCI DSS | 🔴 Must |
| **Paymob** | MENA | Card/wallet | Medium | PCI DSS | 🟠 Should |
| **bKash** | Bangladesh | Wallet | Medium | Local | 🟡 Could |
| **Easypaisa** | Pakistan | Wallet | Medium | Local | 🟡 Could |
| **JazzCash** | Pakistan | Wallet | Medium | Local | 🟡 Could |
| **MPGS** | Global | Card (bank-hosted) | Medium | PCI DSS | 🟡 Could |
| **Safepay** | Pakistan | Card | Medium | PCI DSS | 🟡 Could |
| **8B** | Central Asia | Card | Medium | PCI DSS | 🟡 Could |

### 2.2 Remittance Aggregators
| Provider | Corridors | Use Case | Complexity | Regulation | MVP? |
|----------|-----------|----------|------------|------------|------|
| **Wise** | Global | Bank transfer | Medium | Licensed | 🟠 Should |
| **Remitly** | Global | Cash pickup | Medium | Licensed | 🟠 Should |
| **Western Union** | Global | Cash pickup | High | Licensed | 🟡 Could |
| **MoneyGram** | Global | Cash pickup | High | Licensed | 🟡 Could |
| **Xoom (PayPal)** | Global | Bank/wallet | Medium | Licensed | 🟡 Could |
| **Ria** | Global | Cash pickup | Medium | Licensed | 🟡 Could |

### 2.3 KYC Partners
| Provider | Coverage | Features | Complexity | Regulation | MVP? |
|----------|----------|----------|------------|------------|------|
| **Sumsub** | Global | IDV, Liveness, AML | Medium | GDPR | 🔴 Must |
| **Onfido** | Global | IDV, Liveness | Medium | GDPR | 🟠 Should |
| **Jumio** | Global | IDV, Liveness | Medium | GDPR | 🟠 Should |
| **Shufti Pro** | Global | IDV, AML | Low | GDPR | 🟡 Could |
| **ComplyCube** | UK/EU | IDV, AML | Low | GDPR | 🟡 Could |

### 2.4 AML/Sanctions Screening
| Provider | Coverage | Features | Complexity | Regulation | MVP? |
|----------|----------|----------|------------|------------|------|
| **ComplyAdvantage** | Global | Real-time screening | Medium | N/A | 🔴 Must |
| **Refinitiv (LSEG)** | Global | Comprehensive | High | N/A | 🟠 Should |
| **Dow Jones** | Global | Risk data | High | N/A | 🟡 Could |
| **LexisNexis** | Global | Risk data | High | N/A | 🟡 Could |

### 2.5 FX Rate Providers
| Provider | Coverage | Update Freq | Cost | Complexity | MVP? |
|----------|----------|-------------|------|------------|------|
| **XE.com** | Global | Real-time | Paid | Low | 🟠 Should |
| **Open Exchange Rates** | Global | Hourly | Freemium | Low | 🟡 Could |
| **Fixer.io** | Global | Hourly | Freemium | Low | 🟡 Could |
| **Provider rates** | Corridor | Real-time | Free | Low | ✅ Current |

### 2.6 Notification Providers
| Provider | Channels | Features | Complexity | Cost | MVP? |
|----------|----------|----------|------------|------|------|
| **Firebase FCM** | Push | Free, reliable | Low | Free | ✅ Implemented |
| **OneSignal** | Push/Email/SMS | Multi-channel | Low | Freemium | 🟡 Could |
| **Twilio** | SMS | Global coverage | Medium | Pay-per-use | 🟠 Should |
| **SendGrid** | Email | Transactional | Low | Freemium | 🟠 Should |
| **Mailgun** | Email | Transactional | Low | Freemium | 🟡 Could |

### 2.7 Bank Aggregation (Account Linking)
| Provider | Coverage | Method | Complexity | Regulation | MVP? |
|----------|----------|--------|------------|------------|------|
| **Plaid** | US/CA/UK/EU | Open Banking | Medium | PSD2 | 🟠 Should |
| **Yodlee** | Global | Screen scraping | High | N/A | 🟡 Could |
| **TrueLayer** | UK/EU | Open Banking | Medium | PSD2 | 🟡 Could |
| **Teller** | US | Open Banking | Medium | N/A | 🟡 Could |
| **Finicity** | US/CA | Open Banking | Medium | N/A | 🟡 Could |

---

## 3. Integration Priority Matrix

### 🔴 P0 — Must Have (Pre-Launch)
| Integration | Why | Timeline |
|-------------|-----|----------|
| Sumsub (KYC) | Regulatory requirement | Week 1-2 |
| ComplyAdvantage (AML) | Compliance requirement | Week 1-2 |
| Stripe (PAYIN) | Primary revenue | Week 2-4 |

### 🟠 P1 — Should Have (Month 1)
| Integration | Why | Timeline |
|-------------|-----|----------|
| Wise (Remittance) | User demand | Week 4-6 |
| Remitly (Remittance) | User demand | Week 4-6 |
| XE.com (FX) | Accurate rates | Week 4-6 |
| SendGrid (Email) | Transactional emails | Week 2-3 |

### 🟡 P2 — Could Have (Month 2-3)
| Integration | Why | Timeline |
|-------------|-----|----------|
| bKash/Easypaisa/JazzCash | Local wallets | Month 2 |
| Plaid (Bank Link) | Auto-sync | Month 3 |
| OneSignal (Multi-channel) | Marketing | Month 2 |

### 🟢 P3 — Future Roadmap
| Integration | Why | Timeline |
|-------------|-----|----------|
| Western Union | Cash pickup | Q2 |
| Jumio (KYC backup) | Redundancy | Q2 |
| TrueLayer (EU expansion) | EU market | Q3 |

---

## 4. Regulatory Considerations

### 4.1 KYC/AML Compliance
| Jurisdiction | Requirement | Partner | Status |
|--------------|-------------|---------|--------|
| Canada | FINTRAC MSB | Pending | 🔴 Needed |
| Pakistan | SBP AML | Manual | 🟠 Manual |
| Bangladesh | Bangladesh Bank | Manual | 🟠 Manual |
| UAE | DFSA/CBU | Pending | 🔴 Needed |

### 4.2 Data Privacy
| Regulation | Requirement | Status |
|------------|-------------|--------|
| GDPR (EU) | Consent, deletion, portability | 🟡 Partial |
| PIPEDA (Canada) | Consent, breach notification | 🟡 Partial |
| PDPA (Singapore) | Consent, access rights | 🟡 Partial |

### 4.3 PCI DSS (Card Data)
| Requirement | Approach | Status |
|-------------|----------|--------|
| SAQ-A | Hosted fields/iFrame | ✅ Planned |
| Encryption | TLS 1.3 | ✅ Implemented |
| Tokenization | Provider tokens | ✅ Planned |

---

## 5. Integration Complexity Assessment

### Low Complexity (1-2 weeks)
- API Key authentication
- REST endpoints
- JSON request/response
- Webhook callbacks
- Good documentation

**Examples:** SendGrid, XE.com, OneSignal

### Medium Complexity (2-4 weeks)
- OAuth2 flows
- HMAC signing
- Rate limiting
- Error handling
- Sandbox testing

**Examples:** Stripe, Wise, Sumsub, ComplyAdvantage

### High Complexity (1-2 months)
- Custom encryption
- SOAP/XML
- File-based integration
- Complex auth flows
- Limited documentation

**Examples:** MTB, Agrani Bank, Brac Bank, Standard Bank

### Very High Complexity (2-3 months)
- Hardware security modules
- Custom cryptography
- DLL integration
- Regulatory approval
- On-premise deployment

**Examples:** UCB (DLL), Brac Bank (JWE)

---

## 6. API Integration Checklist

### Pre-Integration
- [ ] API documentation review
- [ ] Sandbox access requested
- [ ] Compliance approval (legal)
- [ ] Security review
- [ ] Cost/budget approval

### Integration Phase
- [ ] Auth implementation
- [ ] Endpoint wrappers
- [ ] Error handling
- [ ] Retry logic
- [ ] Timeout configuration
- [ ] Webhook handlers
- [ ] Logging/monitoring

### Testing Phase
- [ ] Unit tests
- [ ] Integration tests
- [ ] Sandbox E2E tests
- [ ] Error case tests
- [ ] Load tests
- [ ] Security review

### Go-Live
- [ ] Production credentials
- [ ] Production endpoints
- [ ] Monitoring alerts
- [ ] Rollback plan
- [ ] Support documentation

---

*API Integration Research — Felo Engineering War Room — 2026-05-02*
