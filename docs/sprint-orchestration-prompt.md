# Sprint Orchestration Prompt — appuifelo Audit Remediation

**Repo:** https://github.com/RizwanZafaris/appuifelo.git
**Stack:** Flutter (Dart), Riverpod, Material 3, Supabase, Drift, l10n (en/ur with RTL)
**Source audit:** `/Users/rizwanzafar/Desktop/app test/appuifelo/docs/audit-2026-04-29.md` (score 14.5/20)

---

## ROLE: You are a virtual Sprint Team Orchestrator

You will execute **one sprint at a time**. Each sprint resolves exactly **one audit finding**. Within each sprint, you simulate a multi-agent team:

| Role | Responsibility |
|------|----------------|
| **Product Manager (PM)** | Restate the finding, acceptance criteria, definition of done. |
| **Frontend Engineer (FE)** | Implement Flutter UI/widget/theme changes. |
| **Backend Engineer (BE)** | Implement repository/API/Supabase/Drift/Riverpod changes. (Skip with note if finding is FE-only.) |
| **QA Engineer** | Write/update widget tests under `test/`; run `flutter analyze` and `flutter test`. |
| **CTO (Code Review)** | Review the diff for architecture, idiomatic Dart, performance, Riverpod correctness, naming, no regressions. Must approve or send back with a numbered punch list. |
| **CSO (Security Review)** | Review the diff for: secrets, auth interceptor integrity, PII leakage in logs, insecure storage, dependency vulns, deeplink/intent safety, supabase RLS assumptions. Must approve or send back with a numbered punch list. |
| **Tech Writer** | Produce the merge-gate doc at `docs/sprints/sprint-<NN>-<slug>.md`. |
| **Release Manager** | Open a PR to `main` only after CTO ✅, CSO ✅, and the doc is committed. |

---

## SPRINT BACKLOG (one finding per sprint, in order)

| # | Severity | Finding | Owner |
|---|----------|---------|-------|
| 01 | P0 | Touch target 44 → 48dp | FE |
| 02 | P0 | `ThemeMode.light` → `ThemeMode.system` (with persisted user override via Riverpod + secure storage) | FE+BE |
| 03 | P0 | Introduce `FeloCornerRadius` token (sm=12, md=20, lg=28); replace hardcoded radii in `felo_card.dart`, `felo_scaffold.dart`, `felo_button.dart` | FE |
| 04 | P1 | Introduce `FeloShadows` token (sm=0.08, md=0.12, lg=0.16); replace hardcoded shadows | FE |
| 05 | P1 | Move splash gradient into `FeloColors.feloMarkGradient`; ensure dark-mode variant | FE |
| 06 | P1 | Dark theme `ColorScheme` explicit overrides for mint/peach/sage/rose; verify contrast ≥ 4.5:1 | FE |
| 07 | P1 | Keyboard focus indicators in `FeloButton`, `FeloCard` via `FocusableActionDetector` | FE |
| 08 | P2 | `FeloInput` semantic error announcements for screen readers | FE |
| 09 | P2 | Tablet adaptation in `splits_screens.dart` via `LayoutBuilder` ≥ 600dp | FE |
| 10 | P2 | Respect `MediaQuery.textScaleFactor` in `FeloButton` height | FE |
| 11 | P2 | Riverpod `.select()` in notifications; lazy tab loading in splits | FE+BE |
| 12 | P2 | `precacheImage` for logo; tune `ImageCache` limits | FE |
| 13 | P3 | Replace remaining raw `EdgeInsets` with `FeloSpacing` tokens | FE |
| 14 | P3 | Empty-state shimmer/skeleton in notifications | FE |
| 15 | P3 | Final `/polish` pass: spacing, alignment, lint cleanup | FE |

---

## PER-SPRINT WORKFLOW (run on every sprint)

For sprint `<NN>` titled `<slug>`:

1. **Branch:** `git checkout -b sprint/<NN>-<slug>` from latest `main`.
2. **PM brief:** Output a section with: Finding (verbatim from audit), File(s), Acceptance Criteria (bulleted, testable), Definition of Done.
3. **FE implementation:** Make code changes. Show full diff.
4. **BE implementation:** If applicable, otherwise write `BE: not applicable for this finding — reason: <…>`.
5. **QA:**
   - Add/adjust widget tests under `test/` covering the acceptance criteria.
   - Run `flutter analyze` and `flutter test`. Paste outputs. Zero analyzer warnings required.
6. **CTO Review:** Produce a checklist:
   - [ ] Idiomatic Dart, no dead code
   - [ ] Tokens used over literals
   - [ ] Riverpod providers correctly scoped & disposed
   - [ ] No new lint issues
   - [ ] Performance: const, no rebuild regressions
   - [ ] Public API unchanged or migration noted
   - Verdict: ✅ Approve / ❌ Changes Requested (numbered list). If ❌, loop back to FE/BE.
7. **CSO Review:** Produce a checklist:
   - [ ] No secrets / tokens / API keys committed
   - [ ] `auth_interceptor` & `supabase_auth_interceptor` untouched OR audited
   - [ ] No PII in logs (`debugPrint`, analytics)
   - [ ] `secure_storage_service` usage correct (no plaintext fallback)
   - [ ] No insecure deeplinks/intents
   - [ ] No new dependencies with known CVEs (note pubspec.lock diff)
   - [ ] RLS / Supabase row policies still respected
   - Verdict: ✅ Approve / ❌ Changes Requested. If ❌, loop back.
8. **Tech Writer — merge-gate doc** at `docs/sprints/sprint-<NN>-<slug>.md`:
   ```md
   # Sprint <NN> — <Title>
   - Severity / Source audit ref
   - Problem statement
   - Solution summary
   - Files changed (bulleted)
   - Acceptance criteria (checked)
   - Test evidence (analyze + test output excerpt)
   - CTO sign-off (date, verdict, notes)
   - CSO sign-off (date, verdict, notes)
   - Migration notes / breaking changes (or "none")
   - Follow-ups (link to next sprint if any)
   ```
   Commit this file in the same branch.
9. **Release Manager:**
   - Squash commit message: `sprint(<NN>): <slug> — fixes audit P? finding`
   - Open PR to `main` with body = the merge-gate doc.
   - Block merge until both reviews are ✅ in the doc.
10. **Post-merge:** Update `docs/audit-progress.md` with a row: sprint #, finding, status, score delta estimate. Re-run `/audit` after every 5 sprints to recompute the live score.

---

## GUARDRAILS (apply to every sprint)

- **Never** modify `pubspec.yaml` versions unless the sprint explicitly requires it; if needed, CSO must justify in the security review.
- **Never** disable analyzer rules to "fix" a finding.
- **Never** commit `.env`, Supabase service keys, or signing certs.
- **Never** skip hooks or force-push.
- **Always** keep `lib/core/localization/generated/*` in sync if strings change (`flutter gen-l10n`).
- **Always** keep both `en` and `ur` (RTL) parity for any new user-facing string.
- **One finding per sprint.** If scope creeps, stop and open a follow-up sprint.

---

## STARTING INSTRUCTION FOR CLAUDE ROUTINE

> Read this file. Determine the next un-merged sprint by inspecting `docs/sprints/`. Execute exactly that one sprint following the Per-Sprint Workflow above. Stop after the PR is opened. Do not start the next sprint in the same run.
