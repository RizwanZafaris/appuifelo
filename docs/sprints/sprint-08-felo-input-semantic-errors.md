# Sprint 08 — `FeloInput` Semantic Error Announcements

**Severity:** P2 (Accessibility)
**Source audit:** `/audit` 2026-04-29 — Accessibility finding (input errors not announced to screen readers)

## Problem
`FeloInput` rendered `errorText` visually via `InputDecoration.errorText`, but Flutter's default `TextField` does not eagerly announce new errors to assistive tech. Screen-reader users could submit a form, see the visual red helper text, and never hear the error — a WCAG 3.3.1 (Error Identification) gap.

There was also no first-class way to mark a field as required for assistive tech.

## Solution
Convert `FeloInput` to `StatefulWidget`. Wrap the `TextField` in a `Semantics(textField: true, liveRegion: hasError, label, hint)` and:

- On `errorText` change to a new non-empty value, call `SemanticsService.announce('<label>: <error>', Directionality.of(context))` — debounced via `_previousError` so identical errors don't re-announce.
- Add a `required: bool = false` parameter — when true, the visible label gets a trailing `*` and the semantic hint includes "required".
- Compose a `semanticHint` from required-flag, original `hint`, and current error.

## Repos touched
- `appuifelo` (FE)
- `appbackendfelo` — **BE: not applicable.** Pure FE accessibility upgrade.

## Files changed
- `lib/shared/widgets/felo_input.dart` — Stateful conversion, Semantics wrap, announce logic, new `required` parameter.
- `test/shared/widgets/felo_input_semantics_test.dart` (new — 5 widget tests).

## Acceptance criteria
- [x] Field exposes `Semantics(textField: true, label: <label>)`.
- [x] `liveRegion: true` while in error state.
- [x] New error announced exactly once via `SemanticsService.announce`.
- [x] Identical error does not re-announce.
- [x] `required: true` adds `*` to visible label and "required" to semantic hint.
- [x] Public API is additive (no breaking changes for existing call sites).
- [x] Directionality threaded correctly (RTL/Urdu compatible).
- [x] `flutter analyze` reports no warnings/errors (3 info-level deprecation hints for unreleased Flutter 3.35+ APIs are acceptable).
- [x] Tests 5/5 pass.

## Test evidence
```
flutter analyze lib/shared/widgets/felo_input.dart test/shared/widgets/felo_input_semantics_test.dart
3 info-level deprecation hints (announce → sendAnnouncement, hasFlag → flagsCollection;
both target Flutter SDK versions not yet released in our toolchain).
0 warnings, 0 errors.

flutter test test/shared/widgets/felo_input_semantics_test.dart
+5: All tests passed!
  ✓ exposes textField semantics with the label
  ✓ marks liveRegion when errorText is present
  ✓ does not mark liveRegion when no error
  ✓ announces new error via SemanticsService.announce
  ✓ required flag adds visual asterisk and semantic hint
```

The "announce" test intercepts the `SystemChannels.accessibility` mock channel to assert exactly-once delivery — protects against announcement spam on rebuilds.

## CTO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: Stateful conversion necessary to debounce. Public API strictly additive (`required` defaults to `false`). RTL safe via `Directionality.of`.

## CSO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve **with usage rule**
- Notes: No deps/secrets/network. **Usage rule documented:** `errorText` is now spoken verbatim by screen readers — callers MUST pass only sanitized, localized strings (never raw user input or PII). Existing call sites use the `validators` module which already returns sanitized localized messages, so no audit follow-ups needed.

## Migration notes
None. `required: false` default preserves all current behavior. Existing fields gain liveRegion announcements automatically — strictly additive.

## Cross-sprint coordination
- Pairs with sprint 02 (system theme) and sprint 06 (dark theme) — semantic surface is theme-agnostic.
- Future inputs that use `required: true` need en + ur l10n parity for any caller-visible labels (no new strings introduced by this sprint itself).

## Follow-ups
- Migrate to `SemanticsService.sendAnnouncement` and `flagsCollection` once we upgrade past Flutter 3.35.
- Pass `required: true` at call sites for actually-required form fields (e.g., split currency, amount, name) — separate sprint.
- Apply the same pattern to bespoke text inputs outside `FeloInput` (search box, chat composer) once they exist.
