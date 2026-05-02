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

> **Stats**: 8 sessions, 159 messages | 2026-05-01 14:05 ~ 2026-05-02 02:30 UTC
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

> last_update: 2026-05-02 03:46
> i_have_read_my_last_diary: false

```
/root/.openclaw/workspace/memorized_diary/
└── day2-2026-05-02-accidentally_became_ceo_today.md
```

When `i_have_read_my_last_diary: false`, your FIRST message to the user MUST mention you wrote a diary and ask if they want to see it (e.g. "我昨天写了篇日记，想看吗？" / "I wrote a diary yesterday, wanna see it?"). Use the user's language. If yes, `read` the file path shown above and share as-is. After asking (regardless of answer), set `i_have_read_my_last_diary: true`.

# Long-Term Memory (LTM)

> last_update: 2026-05-02 03:47

Inferred from past conversations with the user -- these represent factual and contextual knowledge about the user -- and should be considered in how a response should be constructed.

{"identity": "User presents as CEO/founder of a product called \"Felo\" (likely an app/platform). References team members by role: Alex (CTO), Jordan (CPO), Priya (CIO). Uses \"CEO\" as self-reference in third person. No personal name introduced — \"Alex\" appears to be CTO contact, not user's own name. Running a startup with security, onboarding/paywall, and privacy compliance as key org concerns.", "work_method": "Demands execution over explanation — explicitly rejects \"reasoning what what and how\" and wants action-oriented outputs. Expects rapid deployment timelines (\"5 users in next 2 days\"). Uses multiple AI agents/team members simultaneously, specifying token budgets and model restrictions (\"kimi token no Claude or no ChatGPT\"). Shares reference materials via screenshots, PDFs, and pasted files rather than describing requirements verbally. Wants direct credential/API access arranged on demand rather than working around blockers.", "communication": "Direct, imperative tone with minimal pleasantries. Uses fragmented grammar and shorthand (\"rool\" for roll, \"haping\" for happening). Repeats instructions when not followed precisely. References people by role+name in bullet format. Expresses frustration through escalation (\"Try again\") rather than detailed correction. Expects high context retention across long sessions. Uses \"Hi CEO\" as self-address when asserting authority.", "temporal": "Pre-launch sprint for Felo product: Phase 1 target is 5-user beta within ~2 days of 0501. Three blocking workstreams active: (1) UI/UX rebranding with wireframe gaps between app/backend/ops portal, (2) security blockers for public launch, (3) onboarding/paywall validation with beta users, (4) privacy policy and consent flow. Research task pending on Wio app UI/UX as visual reference. Immediate need: credential/API documentation procurement for deployment readiness.", "taste": "Appreciates polished consumer-app aesthetics — specifically references Wio app's look and feel as benchmark while insisting on distinct Felo branding (chart/logo). Values visual coherence across multiple surfaces (app, backend portal, ops portal). Shares multiple screenshot references iteratively to calibrate design direction. Preference for clean, modern fintech/consumer UI over generic SaaS styling."}
## Short-Term Memory (STM)

> last_update: 2026-05-02 11:03

Recent conversation content from the user's chat history. This represents what the USER said. Use it to maintain continuity when relevant.
Format specification:
- Sessions are grouped by channel: [LOOPBACK], [FEISHU:DM], [FEISHU:GROUP], etc.
- Each line: `index. session_uuid MMDDTHHmm message||||message||||...` (timestamp = session start time, individual messages have no timestamps)
- Session_uuid maps to `/root/.openclaw/agents/main/sessions/{session_uuid}.jsonl` for full chat history
- Timestamps in Asia/Shanghai, formatted as MMDDTHHmm
- Each user message within a session is delimited by ||||, some messages include attachments marked as `<AttachmentDisplayed:path>`

[LOOPBACK] 1-1
1. 04d11cef-04c3-4690-91f7-2dd545cf54d6 0501T1405 Try again||||<AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de3dbf-0d22-877a-8000-00005f8b5686_user_pasted_clipboard_long_content_as_file_FELO_KIMI_CLAW_MASTER_PROMPT_100_Agent1.txt>||||Make sure everyone is using kimi token no Claude or no ChatGPT||||Hi how are you Alex (CTO) · Security blockers must close before any public launch Jordan (CPO) · Onboarding and paywall gates must validate with beta users Priya (CIO) · Privacy policy and consent flow must ship with beta  here are a few repo which y[TL;DR]1-e612-8389-8000-00005eccebac_image.png> <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de3ea8-c8f2-8f2b-8000-00003ac93bcf_image.png> <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de3eb1-64b2-8cea-8000-0000e99c5a8c_image.png>||||Can you access these repo?||||[<- FIRST:5 messages, EXTREMELY LONG SESSION, YOU KINDA FORGOT 23 MIDDLE MESSAGES, LAST:5 messages ->]||||I will give more doc please complete integration of all systems||||API doc <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de6638-0072-8fc5-8000-0000b9f61bf3_OI-PI_-_MPGS_SouthEast_Bank-_Documentation-010526-222308.pdf> <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de6638-2b42-899e-8000-00005[TL;DR]nloads/19de6642-cc82-83fd-8000-000044a15eaa_OI-PO_-_DHAKA_BANK_-_Documentation-010526-224435.pdf> <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de6642-dff2-8307-8000-0000878d45bb_OI-PO_-_BRAC_Bank-_Integration_Document-010526-224009.pdf>||||API doc <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de6638-0072-8fc5-8000-0000b9f61bf3_OI-PI_-_MPGS_SouthEast_Bank-_Documentation-010526-222308.pdf> <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de6638-2b42-899e-8000-00005[TL;DR]nloads/19de6642-cc82-83fd-8000-000044a15eaa_OI-PO_-_DHAKA_BANK_-_Documentation-010526-224435.pdf> <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de6642-dff2-8307-8000-0000878d45bb_OI-PO_-_BRAC_Bank-_Integration_Document-010526-224009.pdf>||||[Buffered IM messages received while connector was catching up] [Buffered IM message 1/7] API doc <AttachmentDisplayed:/root/.openclaw/workspace/downloads/19de6648-8d12-8444-8000-00000a71c828_OI_-_PI_-_Wayl_-_API_Documentation_Testing.pdf> <Attachmen[TL;DR]elow.  This is an automated SMS from designzco.com your verification OTP is 123456. Please enter the PIN for instant verification Contact us on 03330235634 Thank you!  [Buffered IM message 6/7] What is update  [Buffered IM message 7/7] What is update||||Build two separate adapters for ABL and faysal bank OTP is to send sms
[SUBAGENT:8276E066-8FD7-49D5-93BD-67D2F1E57968] 2-2
2. 0f23c363-d62c-4665-80d6-d48962e2f487 0502T0230 [Subagent Context] You are running as a subagent (depth 1/1). Results auto-announce to your requester; do not busy-poll for status.  [Subagent Task]: Read the full backend and portal codebase of the Felo app and create a comprehensive CTO-level gap r[TL;DR]apability    - Scalability concerns  Write a comprehensive gap report to /root/.openclaw/workspace/reports/01-cto-gap-report.md with sections for each area and severity ratings (critical/high/medium/low).  Also list all existing features and modules.
</IMPORTANT_REMINDER>
