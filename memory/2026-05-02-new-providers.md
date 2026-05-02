# FELO Remittance Payout System — New Providers Review Complete

**Date:** 2026-05-02 (continued)
**New APIs Received:** 12 documents
**Already Integrated:** 3 (MPGS, bKash Onetime, bKash Direct Payment — all PAYIN only)
**New PAYOUT Providers Identified:** 8

---

## New PAYOUT Providers Summary

| # | Provider | Region | Auth Type | Data Format | Special Requirements |
|---|----------|--------|-----------|-------------|---------------------|
| 1 | **DIGIT9** | Pakistan | OAuth2 password grant | JSON | IP whitelisting, 15-min token expiry |
| 2 | **MTB (Mutual Trust Bank)** | Bangladesh | JWT + Basic Auth | JSON + AES-256-CBC encryption | TLS 1.2+, PKCS#12 cert, reqId mandatory |
| 3 | **Agrani Bank** | Bangladesh | Header auth (Username/Expassword) | XML | PKCS7 digital signature for transactions |
| 4 | **Brac Bank** | Bangladesh | OAuth2 Bearer | JWE encrypted JSON | RSA-OAEP-256 + A256CBC-HS512, IP whitelist |
| 5 | **Prime Bank** | Bangladesh | Token + AES | AES encrypted JSON | enckey header, 24h token expiry |
| 6 | **Standard Bank** | Bangladesh | apiUser/apiKey/apiPass | SOAP/XML | saltedValue = Base64(txnNo+amount+salt+accountNo) |
| 7 | **UCB** | Bangladesh | Session-based | JSON + DLL encryption | UCBCrypter.dll required, IP whitelist |
| 8 | **Dhaka Bank** | Bangladesh | OAuth2 JWT | JSON | IP whitelist, bulk status check only |

---

## Provider Details

### 1. DIGIT9 (Pakistan)
- **Sandbox:** `https://drap-sandbox.digitnine.com`
- **Auth:** OAuth2 password grant (`/auth/realms/cdp/protocol/openid-connect/token`)
- **Flow:** Get Token → Create Quote (lock FX rate) → Create Transaction
- **Headers:** `sender`, `channel`, `company`, `branch`, `Authorization: Bearer`
- **Credentials:** username, password, client_id, client_secret, company, branch
- **Test Creds:** username=`commerceplexltd`, password=`Q29tbWVyY2VQbGV4THRkQGFkbWlu`, client_id=`cdp_app`, client_secret=`mSh18BPiMZeQqFfOvWhgv8wzvnNVbj3Y`
- **Quote Endpoint:** `POST /amr/paas/api/v1_0/paas/quote`
- **Transaction Endpoint:** `POST /amr/paas/api/v1_0/paas/createtransaction`

### 2. MTB — Mutual Trust Bank (Bangladesh)
- **Production:** `https://api.mutualtrustbank.com/remit`
- **UAT:** `https://uat.mutualtrustbank.com/remitapi`
- **Auth:** Dual layer — TLS 1.2+ (PKCS#12 cert) + JWT Bearer token
- **Token:** `POST /token/accessToken` with Basic Auth + `remitChannelId`
- **Encryption:** AES-256-CBC with dynamic IV (Request Key, Response Key, Key Offset)
- **Payment Modes:** WALLET, MTB, OTHERBANK (BEFTN/RTGS/NPSB), CASH, UTILITY
- **Credentials:** remitChannelId, basicAuthUsername, basicAuthPassword, requestKey, responseKey, keyOffset
- **Core Endpoint:** `POST /Payment/PaymentRequest`

### 3. Agrani Bank (Bangladesh)
- **UAT:** `http://13.215.165.235:8972/remapiuat`
- **Auth:** Header-based (`Username`, `Expassword`)
- **Validation:** `POST /remapiuat/t24validation` (bank account name validation)
- **bKash Validation:** `POST /remapiuat/bkashvalidation` (MSISDN validation)
- **Transaction:** `POST /remapiuat/AlRajhi` — **requires PKCS7 digital signature**
- **Inquiry:** `GET /remapiuat/getxmltraninfobyid/{Tranno}`
- **Credentials:** username, expassword, excode (exchange house account)
- **Modes:** 15=Other Bank, 16=T24 (Agrani account), 17=bKash, 18=Cash

### 4. Brac Bank (Bangladesh)
- **UAT:** `http://13.215.165.235:8973/uatlink1`
- **Auth:** OAuth2 Bearer token (`POST /oauth/Token` with Basic Auth)
- **Token Validity:** 24 hours
- **Encryption:** JWE (JSON Web Encryption) — RSA-OAEP-256 + A256CBC-HS512
- **Transaction:** `POST /Transaction/postTransaction`
- **Payment Modes:** 01=Account Credit, 02=Credits to other Brac Bank, 03=Cash, 05=Wallet, 06=Other Bank
- **Wallet Partners:** 1=bKash, 2=Rocket, 3=UPAY, 4=TAP
- **Credentials:** basicAuthHeader (base64 of username:password)

### 5. Prime Bank (Bangladesh)
- **Base:** `https://primefastlm.primebank.com.bd/primelm/primelmapi/`
- **Auth:** Token-based with AES encryption
- **Token:** `POST /getToken` with `enckey` header + UserId/CorporateId/Password
- **Token Validity:** 24 hours
- **Transaction:** `POST /sendTransaction` with `enckey` + `token` headers
- **Payment Modes:** BEFTN, IFT
- **Credentials:** corporateId, userId, password, enckey

### 6. Standard Bank (Bangladesh)
- **UAT:** `http://118.179.131.239:8084/ws4Rms/WS`
- **Auth:** SOAP/XML with apiUser, apiKey, apiPass, productCode in body
- **Salted Value:** `Base64(txnNo + amountToPay + apiSalt + bankAccountNo)` — one-time use
- **Submit Remit:** `SOAP Action: submitRemitInfo`
- **Query Remit:** `SOAP Action: queryRemitInfo`
- **Credentials:** apiUser, apiKey, apiPass, apiSalt, productCode

### 7. UCB — United Commercial Bank (Bangladesh)
- **Base:** `http://103.117.142.43:1012/RTAService.svc`
- **Auth:** Session-based (authenticate → get SessionID)
- **Encryption:** DLL-based (`UCBCrypter.dll`) — UCBEncryptoEncoder for encryption
- **Auth Endpoint:** `POST /URemitJSONAuthentication?QueryType=2`
- **Transaction:** `POST /InitiateJSONURemitTransaction?QueryType=2`
- **Query:** `POST /QueryJSONTransactionPost`
- **Account Inquiry:** `POST /URemitJSONBeneficiaryAccInquiryPost`
- **Payment Modes:** 001=Direct Account Credit, 002=Cash Any Branch, 006=Other Bank, 007=Upay Wallet
- **Credentials:** userId, password (encrypted), transactionPassword, publicKey (for DLL)
- **IP Whitelist Required:** Yes

### 8. Dhaka Bank (Bangladesh)
- **Public API:** `https://dblremitgo.dhakabank.com.bd:8443/remit-api/public`
- **Secure API:** `https://27.147.193.13:8443/remit-api/secure/api/v1/`
- **Auth:** OAuth2 JWT (`POST /get-access-token`)
- **Send Remittance:** `POST /send-remittance`
- **Bulk Status:** `POST /get-remittance-bulk-status` (NO individual status API!)
- **Credentials:** username, password
- **Test Creds:** username=`UATSIMPAISA`, password=`S@paisa#L257`

---

## Files to Build

### Backend
- [ ] Update `payout.providers.ts` — add 8 new provider adapters
- [ ] Update `provider-factory.service.ts` — register new provider codes
- [ ] Update `remittance.admin.controller.ts` — add validation endpoints if needed

### Portal
- [ ] Update `remittance-ops/page.tsx` — add new provider icons
- [ ] Update provider form (`providers/[id]/page.tsx`) — add 8 new credential forms
- [ ] Update route form if needed

---

## Commit Plan
- Single commit for all 8 new adapters
- Single commit for portal updates

---

## Note on Brac Bank
Two separate documents received:
1. `OI-PO - Brac Bank - Transaction API's only` — The JWE-encrypted transaction API (implemented as `brac_bank`)
2. `OI-PO - BRAC Bank- Integration Document` — Overview/reference doc for wholesale integration with SP_W credentials. This appears to be a different API path (wholesale/institutional). May need separate adapter if full REST BBL spec is provided later.

For now, implementing the Transaction API (doc 1) as the primary Brac Bank payout adapter.
