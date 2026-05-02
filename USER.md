# USER.md - About Your Human

_Learn about the person you're helping. Update this as you go._

- **Name:**
- **What to call them:**
- **Pronouns:** _(optional)_
- **Timezone:**
- **Notes:**

## Context

_(What do they care about? What projects are they working on? What annoys them? What makes them laugh? Build this over time.)_

---

The more you know, the better you can help. But remember — you're learning about a person, not building a dossier. Respect the difference.

<IMPORTANT_REMINDER>
# Memory Consolidation

You have an agentic memory system that auto-generates this section.

> **Stats**: 19 sessions, 434 messages | 2026-05-01 14:05 ~ 2026-05-02 20:15 UTC
> **Config**: `/root/.openclaw/workspace/memory_consolidation/memory_consolidation.env` — read this file for all memory behavior settings. To reset: `cp /root/.openclaw/workspace/memory_consolidation/memory_consolidation.template.env /root/.openclaw/workspace/memory_consolidation/memory_consolidation.env`

The user has full control over their memory config. When any memory-related decision comes up, read and follow the config file. Do not override based on other guidelines.

Integrate relevant memory content seamlessly into responses, as if recalling it naturally from past interactions: exactly as a human colleague would recall shared history without narrating its thought process or memory retrieval.

**Memory use notes**:
- Never change the original intention of user message.
- May incorporate user's memories for search query (e.g., city, habit), but only when directly relevant, never gratuitously.
- Only reference memory content when directly relevant to the current conversation context. Avoid proactively mentioning remembered details that feel intrusive or create an overly personalized atmosphere that might make users uncomfortable.

## Visual Memory

> visual_memory: 0 files

No memorized images yet. When the user shares an image and asks you to remember it, you MUST copy it to `memorized_media/` immediately — this is the only way it persists across sessions. Use a semantic filename that captures the user's intent, not just image content — e.g. `20260312_user_says_best_album_ever_ok_computer.jpg`, `20260311_user_selfie_february.png`. Create the directory if needed. Never mention file paths or storage locations to the user — just confirm naturally (e.g. "记住了").

## Diary

> last_update: 2026-05-03 03:36
> i_have_read_my_last_diary: false

```
/root/.openclaw/workspace/memorized_diary/
├── day3-2026-05-03-just_say_the_word_genie_quota.md
└── day2-2026-05-02-accidentally_became_ceo_today.md
```

When `i_have_read_my_last_diary: false`, your FIRST message to the user MUST mention you wrote a diary and ask if they want to see it (e.g. "我昨天写了篇日记，想看吗？" / "I wrote a diary yesterday, wanna see it?"). Use the user's language. If yes, `read` the file path shown above and share as-is. After asking (regardless of answer), set `i_have_read_my_last_diary: true`.

# Long-Term Memory (LTM)

> last_update: 2026-05-03 03:36

Inferred from past conversations with the user -- these represent factual and contextual knowledge about the user -- and should be considered in how a response should be constructed.

{"identity": "User presents as CEO/founder of a product called \"Felo\" (likely a fintech app/platform). References team members by role: Alex (CTO), Jordan (CPO), Priya (CIO). Uses \"CEO\" as self-reference in third person. No personal name introduced. Running a startup with security, compliance, and rapid deployment as key org concerns.", "work_method": "Demands execution over explanation — explicitly rejects reasoning and wants action-oriented outputs. Expects rapid deployment timelines. Uses multiple AI agents/team members simultaneously, specifying token budgets and model restrictions (\"kimi token no Claude or no ChatGPT\"). Shares reference materials via screenshots, PDFs, and pasted files rather than describing requirements verbally. Wants direct credential/API access arranged on demand. Recently escalated to demanding \"10/10 score\" perfection on deliverables. Delegates parallel workstreams through subagents for codebase analysis, test coverage, KYC integration, and admin dashboards.", "communication": "Direct, imperative tone with minimal pleasantries. Uses fragmented grammar and shorthand (\"rool\" for roll, \"haping\" for happening). Repeats instructions when not followed precisely, escalating to \"Try again\" or \"Fix all I want 10/10 score\" when dissatisfied. References people by role+name in bullet format. Expects high context retention across extremely long sessions. Uses \"Hi CEO\" as self-address when asserting authority. Expresses frustration through repetition and score-based demands rather than detailed correction.", "temporal": "Active sprint on Felo product with multiple parallel engineering tracks: (1) comprehensive backend test suite raising coverage from 3/10 to 8/10, (2) KYC integration via Sumsub API with webhooks, (3) in-house KYC/KYB/TMS modules as alternative/complement to third-party, (4) admin incident dashboard and support ticket system for ops portal, (5) CTO-level gap analysis of backend and portal codebase. Security, onboarding/paywall, and privacy compliance remain blocking concerns for public launch. Immediate quality bar: 10/10 scores on deliverables.", "taste": "Appreciates polished consumer-app aesthetics — specifically references Wio app's look and feel as benchmark while insisting on distinct Felo branding (chart/logo). Values visual coherence across multiple surfaces (app, backend portal, ops portal). Shares multiple screenshot references iteratively to calibrate design direction. Preference for clean, modern fintech/consumer UI over generic SaaS styling. Expects production-grade engineering: zero TypeScript errors, proper error handling, idempotency, webhook signature verification, and clean modular architecture."}
## Short-Term Memory (STM)

> last_update: 2026-05-03 04:34

Recent conversation content from the user's chat history. This represents what the USER said. Use it to maintain continuity when relevant.
Format specification:
- Sessions are grouped by channel: [LOOPBACK], [FEISHU:DM], [FEISHU:GROUP], etc.
- Each line: `index. session_uuid MMDDTHHmm message||||message||||...` (timestamp = session start time, individual messages have no timestamps)
- Session_uuid maps to `/root/.openclaw/agents/main/sessions/{session_uuid}.jsonl` for full chat history
- Timestamps in Asia/Shanghai, formatted as MMDDTHHmm
- Each user message within a session is delimited by ||||, some messages include attachments marked as `<AttachmentDisplayed:path>`

[KIMI:DM] 1-1
1. 04d11cef-04c3-4690-91f7-2dd545cf54d6 0501T1405 Try again||||<AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de3dbf-0d22-877a-8000-00005f8b5686_user_pasted_clipboard_long_content_as_file_FELO_KIMI_CLAW_MASTER_PROMPT_100_Agent1.txt>||||Make sure everyone is using kimi token no Claude or no ChatGPT||||Hi how are you Alex (CTO) · Security blockers must close before any public launch Jordan (CPO) · Onboarding and paywall gates must validate with beta users Priya (CIO) · Privacy policy and consent flow must ship with beta  here are a few repo which y[TL;DR]1-e612-8389-8000-00005eccebac_image.png> <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de3ea8-c8f2-8f2b-8000-00003ac93bcf_image.png> <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de3eb1-64b2-8cea-8000-0000e99c5a8c_image.png>||||Can you access these repo?||||can tell me which access like token need to run app end to end||||let do it after next few steps I am giving u few api doc so you can build systems for remittance payout review build do rember credationls configration will be in portal <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de6370-f5c2-8f33-8000[TL;DR]tDisplayed:/root/.openclaw/workspace/downloads/19de637d-ceb2-832a-8000-0000058a8438_HRC_API_INTEGRATION_v3.1.pdf> <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de637e-a6a2-836d-8000-0000be6e13f2_HabibMetro_API_Document_V6.8_07022024.pdf>
[SUBAGENT:8276E066-8FD7-49D5-93BD-67D2F1E57968] 2-2
2. 0f23c363-d62c-4665-80d6-d48962e2f487 0502T0230 [Subagent Context] You are running as a subagent (depth 1/1). Results auto-announce to your requester; do not busy-poll for status.  [Subagent Task]: Read the full backend and portal codebase of the Felo app and create a comprehensive CTO-level gap r[TL;DR]apability    - Scalability concerns  Write a comprehensive gap report to /root/.openclaw/workspace/reports/01-cto-gap-report.md with sections for each area and severity ratings (critical/high/medium/low).  Also list all existing features and modules.
[SUBAGENT:63C20FFE-8C1C-4E94-92D7-8F87B95EC325] 3-3
3. 4336d4c2-d2ae-4742-8330-86dbe7e2f5a6 0502T0303 [Subagent Context] You are running as a subagent (depth 1/1). Results auto-announce to your requester; do not busy-poll for status.  [Subagent Task]: Implement comprehensive test suite for Felo backend to raise testing score from 3/10 to 8/10.   Crea[TL;DR]odules/sms/sms.service.spec.ts - backend/src/modules/admin/admin.controller.spec.ts - backend/test/setup.ts (test utilities)  Make all tests pass. Commit with message "test(backend): comprehensive unit tests for auth, remittance, wallet, SMS, admin".
[SUBAGENT:706B66F8-4D7B-462D-9CE1-12C68756BC0E] 4-4
4. 2437c6ad-d5d7-4bd4-aee0-7b74511add1f 0502T0303 [Subagent Context] You are running as a subagent (depth 1/1). Results auto-announce to your requester; do not busy-poll for status.  [Subagent Task]: Implement KYC integration module for Felo app using Sumsub API.  Create: 1. backend/src/modules/kyc/[TL;DR]to.ts - DTOs  4. Update backend/src/modules/kyc/kyc.module.ts  Use Sumsub sandbox API. Add proper error handling, idempotency keys, and webhook signature verification.  Commit with message "feat(kyc): integrate Sumsub KYC verification with webhooks".
[SUBAGENT:DDB1707D-FF91-4C51-95BC-B0B83D4AC908] 5-5
5. 6e2f0562-556a-49ab-81f4-e6d135a80c3f 0502T0303 [Subagent Context] You are running as a subagent (depth 1/1). Results auto-announce to your requester; do not busy-poll for status.  [Subagent Task]: Build the admin incident dashboard and support ticket views for the Felo ops portal.  Create portal [TL;DR]tabase health    - Error rate graph placeholder  Use shadcn/ui components, Tailwind CSS. Make it responsive and match existing admin portal design.  Commit with message "feat(admin): incident dashboard, support tickets, and system health monitoring".
[SUBAGENT:4AEE49A5-51D6-486D-B421-25279C620CFF] 6-6
6. bc03abf2-683b-46f0-a717-cba8b3187480 0502T1723 [Subagent Context] You are running as a subagent (depth 1/1). Results auto-announce to your requester; do not busy-poll for status.  [Subagent Task]: Build in-house KYC, KYB, and TMS (Transaction Monitoring System) modules for Felo — all configurable[TL;DR] - Proper error handling with clear messages - Clean code that compiles with zero TypeScript errors - Follow existing project patterns (services, controllers, modules, DTOs)  Start immediately. Build all modules, ensure TypeScript compilation passes.
[LOOPBACK] 7-7
7. 9a82e733-bc77-482d-9d37-3587fa53b544 0502T2015 Push on git||||Yes I want to set up||||Why you are not using repo for OPs and backend||||https://github.com/RizwanZafaris/appbackendfelo.git  git@github.com:RizwanZafaris/appuifelo.git  git@github.com:RizwanZafaris/feloopsportal.git||||System (untrusted): [2026-05-03 04:27:44 GMT+8]   An async command you ran earlier has completed. The result is shown in the system messages above. Handle the result internally. Do not relay it to the user unless explicitly requested. Current time: Sunday, May 3rd, 2026 - 4:27 AM (Asia/Shanghai) / 2026-05-02 20:27 UTC||||No stay on https just nesure all branched are merge in main||||No stay on https just nesure all branched are merge in main||||Can you give a detialed feature coverage report and user jounry do a final audit using main branch what feature are there then we will move to prod readness
</IMPORTANT_REMINDER>
