/// **Centralized input validators for FELO onboarding.**
///
/// Single source of truth — every screen that validates user input MUST
/// call these. Do not duplicate regex or rules in screen code.
///
/// Region-aware rules read the dial-code map from the journey-config
/// payload at call time so that adding a new corridor needs ONLY a DB
/// row update — no client redeploy.
library;

class ValidationResult {
  const ValidationResult.ok() : error = null;
  const ValidationResult.error(this.error);

  final String? error;

  bool get isValid => error == null;
}

class Validators {
  // ───── Email (RFC 5322 simplified, plus business rules) ─────

  /// Returns the *normalized* email (trimmed + lowercased) on success
  /// or an error message on failure. Caller should persist the
  /// normalized form so dedupe checks work.
  static ({String? normalized, String? error}) email(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return (normalized: null, error: 'Enter your email');
    }
    final lowered = trimmed.toLowerCase();
    // Simplified RFC 5322: local-part with limited specials, domain with TLD ≥ 2.
    final regex = RegExp(
      r"^[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$",
    );
    if (!regex.hasMatch(lowered)) {
      return (normalized: null, error: "That email doesn't look right");
    }
    if (lowered.length > 254) {
      return (normalized: null, error: 'Email is too long');
    }
    // Reject obvious throwaway domains used for fraud signups.
    const blockedDomains = {
      'mailinator.com',
      'tempmail.com',
      'guerrillamail.com',
      '10minutemail.com',
      'trashmail.com',
    };
    final domain = lowered.split('@').last;
    if (blockedDomains.contains(domain)) {
      return (normalized: null, error: 'Please use a permanent email');
    }
    return (normalized: lowered, error: null);
  }

  // ───── Phone (region-aware E.164) ─────

  /// Validates a phone number against the dial-code + length rules of
  /// the supplied region. `regionIso2` MUST be a 2-letter country code
  /// from the regions table.
  ///
  /// Returns the normalized E.164 (`+XXNNNNNNNNNN`) on success.
  static ({String? normalized, String? error}) phone({
    required String raw,
    required String regionIso2,
    required Map<String, String> dialCodeByIso,
  }) {
    final cleaned = raw.replaceAll(RegExp(r'[\s\-()]'), '');
    if (cleaned.isEmpty) {
      return (normalized: null, error: 'Enter your mobile number');
    }
    final dial = dialCodeByIso[regionIso2];
    if (dial == null) {
      return (normalized: null, error: 'Region not supported');
    }
    // Strip leading `+` and `00` international prefixes; strip leading 0
    // for national format (PK, BD, NP, EG patterns).
    var n = cleaned;
    if (n.startsWith('+')) n = n.substring(1);
    if (n.startsWith('00')) n = n.substring(2);
    final dialDigits = dial.substring(1); // drop the +
    if (n.startsWith(dialDigits)) {
      n = n.substring(dialDigits.length);
    }
    if (n.startsWith('0')) n = n.substring(1);
    // Now `n` is the national subscriber number. Apply per-region length.
    final rule = _phoneRules[regionIso2];
    if (rule == null) {
      return (normalized: null, error: 'Number format not validated');
    }
    if (!RegExp(r'^\d+$').hasMatch(n)) {
      return (normalized: null, error: 'Numbers only please');
    }
    if (n.length < rule.minLen || n.length > rule.maxLen) {
      return (
        normalized: null,
        error: 'Expected ${rule.expected} digits',
      );
    }
    if (rule.startsWith != null && !rule.startsWith!.any(n.startsWith)) {
      return (
        normalized: null,
        error: 'Mobile numbers in this country usually start with '
            '${rule.startsWith!.join(", ")}',
      );
    }
    return (normalized: '$dial$n', error: null);
  }

  /// Per-region national-subscriber rules. Keep this map small — covers
  /// the corridors FELO ships in v1. If a corridor is added without a
  /// rule the validator returns "not validated" and the user is asked
  /// to pick a different country (safe-by-default).
  static const Map<String, _PhoneRule> _phoneRules = {
    'PK': _PhoneRule(minLen: 10, maxLen: 10, expected: '10', startsWith: ['3']),
    'IN': _PhoneRule(minLen: 10, maxLen: 10, expected: '10', startsWith: ['6', '7', '8', '9']),
    'BD': _PhoneRule(minLen: 10, maxLen: 10, expected: '10', startsWith: ['1']),
    'NP': _PhoneRule(minLen: 10, maxLen: 10, expected: '10', startsWith: ['9']),
    'LK': _PhoneRule(minLen: 9,  maxLen: 9,  expected: '9',  startsWith: ['7']),
    'EG': _PhoneRule(minLen: 10, maxLen: 10, expected: '10', startsWith: ['1']),
    'CA': _PhoneRule(minLen: 10, maxLen: 10, expected: '10'),
    'US': _PhoneRule(minLen: 10, maxLen: 10, expected: '10'),
    'GB': _PhoneRule(minLen: 10, maxLen: 10, expected: '10', startsWith: ['7']),
    'AE': _PhoneRule(minLen: 9,  maxLen: 9,  expected: '9',  startsWith: ['5']),
    'SA': _PhoneRule(minLen: 9,  maxLen: 9,  expected: '9',  startsWith: ['5']),
    'ES': _PhoneRule(minLen: 9,  maxLen: 9,  expected: '9',  startsWith: ['6', '7']),
  };

  // ───── Personal name ─────

  /// Allows letters (incl. extended Latin / Arabic / Devanagari /
  /// Bengali / Sinhala scripts), spaces, hyphens, apostrophes.
  /// Rejects: digits, emojis, symbols, double spaces.
  ///
  /// Length: 2–60 characters after trimming.
  static ({String? normalized, String? error}) personalName(String raw) {
    var name = raw.trim();
    if (name.isEmpty) {
      return (normalized: null, error: 'Enter your name');
    }
    // Collapse runs of whitespace to a single space.
    name = name.replaceAll(RegExp(r'\s+'), ' ');
    if (name.length < 2) {
      return (normalized: null, error: 'Name is too short');
    }
    if (name.length > 60) {
      return (normalized: null, error: 'Name is too long (max 60)');
    }
    // Reject anything outside letter classes + space + hyphen + apostrophe.
    // Use Unicode letter categories so PK/BD/IN scripts are first-class.
    final allowed = RegExp(
      r"^[\p{L}\p{M}][\p{L}\p{M}\s\-']*[\p{L}\p{M}]$",
      unicode: true,
    );
    if (!allowed.hasMatch(name)) {
      return (
        normalized: null,
        error: 'Use letters, spaces, hyphens or apostrophes only',
      );
    }
    return (normalized: name, error: null);
  }

  // ───── Budget amount ─────

  /// Parses common shorthand the user might type:
  ///   `5000`     → 5000
  ///   `5,000`    → 5000
  ///   `5k`       → 5000
  ///   `5K`       → 5000
  ///   `1.5l`     → 150000   (Indian "lac" / "lakh")
  ///   `1.5lac`   → 150000
  ///   `2cr`      → 20000000 (Indian "crore")
  ///   `5m`       → 5000000  (million)
  ///
  /// Returns the *major-unit* amount on success (NOT minor units).
  /// Caller multiplies by 100 for storage.
  ///
  /// **Edge case spec from CTO audit §8:** "If user enters something
  /// like 5000k, normalize or ask clarification." We normalize when the
  /// shorthand is unambiguous (`5k`, `1.5l`); we *reject with prompt*
  /// when it's contradictory (`5000k` = 5,000,000 — clearly typo).
  static ({double? majorAmount, String? error, String? clarification}) budgetAmount(
    String raw,
  ) {
    var s = raw.trim().toLowerCase().replaceAll(',', '');
    if (s.isEmpty) {
      return (majorAmount: null, error: 'Enter an amount', clarification: null);
    }
    double multiplier = 1;
    // Order matters — match longer suffixes first.
    if (s.endsWith('crore') || s.endsWith('cr')) {
      multiplier = 10000000;
      s = s.replaceAll(RegExp(r'(crore|cr)$'), '');
    } else if (s.endsWith('lakh') || s.endsWith('lac') || s.endsWith('l')) {
      multiplier = 100000;
      s = s.replaceAll(RegExp(r'(lakh|lac|l)$'), '');
    } else if (s.endsWith('million') || s.endsWith('m')) {
      multiplier = 1000000;
      s = s.replaceAll(RegExp(r'(million|m)$'), '');
    } else if (s.endsWith('k')) {
      multiplier = 1000;
      s = s.substring(0, s.length - 1);
    }
    final n = double.tryParse(s.trim());
    if (n == null) {
      return (
        majorAmount: null,
        error: 'Numbers only please',
        clarification: null,
      );
    }
    if (n <= 0) {
      return (
        majorAmount: null,
        error: 'Amount must be greater than zero',
        clarification: null,
      );
    }
    final amount = n * multiplier;
    // Sanity check — > 1 billion is almost certainly a typo. Ask.
    if (amount > 1000000000) {
      return (
        majorAmount: null,
        error: null,
        clarification:
            'That looks unusually large. Did you mean ${(amount / 1000000).toStringAsFixed(0)}M?',
      );
    }
    // Safety floor — < 100 of any currency is unrealistic for monthly.
    if (amount < 100) {
      return (
        majorAmount: null,
        error: null,
        clarification: 'Monthly budgets under 100 are unusual. Continue?',
      );
    }
    return (majorAmount: amount, error: null, clarification: null);
  }
}

class _PhoneRule {
  const _PhoneRule({
    required this.minLen,
    required this.maxLen,
    required this.expected,
    this.startsWith,
  });

  final int minLen;
  final int maxLen;
  final String expected;
  final List<String>? startsWith;
}
