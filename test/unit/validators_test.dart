import 'package:flutter_test/flutter_test.dart';

import 'package:felo/shared/validation/validators.dart';

/// Audit §13 — edge-case test coverage for centralized validators.
///
/// Failure here = a real user gets through with bad data. Keep the
/// "rejects" branches at least as thorough as the "accepts" branches.
void main() {
  group('Validators.email', () {
    test('accepts valid email and lowercases + trims', () {
      final r = Validators.email('  Foo.Bar+x@Example.COM ');
      expect(r.error, isNull);
      expect(r.normalized, 'foo.bar+x@example.com');
    });

    test('rejects empty', () {
      expect(Validators.email('').error, isNotNull);
      expect(Validators.email('   ').error, isNotNull);
    });

    test('rejects malformed', () {
      for (final bad in const [
        'no-at-sign',
        'no@tld',
        'no@@double.com',
        'spaces in@local.com',
        'trailing@.com',
      ]) {
        expect(Validators.email(bad).error, isNotNull, reason: 'should reject "$bad"');
      }
    });

    test('rejects throwaway domains (anti-fraud)', () {
      expect(Validators.email('a@mailinator.com').error, isNotNull);
      expect(Validators.email('x@10minutemail.com').error, isNotNull);
    });

    test('rejects oversized email', () {
      final huge = '${'a' * 250}@b.co';
      expect(Validators.email(huge).error, isNotNull);
    });
  });

  group('Validators.phone (region-aware E.164)', () {
    const dialMap = {
      'PK': '+92', 'IN': '+91', 'BD': '+880', 'NP': '+977',
      'CA': '+1', 'GB': '+44', 'AE': '+971', 'EG': '+20', 'ES': '+34',
    };

    test('PK normalizes leading 0 + 03 mobile prefix', () {
      final r = Validators.phone(
        raw: '03001234567',
        regionIso2: 'PK',
        dialCodeByIso: dialMap,
      );
      expect(r.error, isNull);
      expect(r.normalized, '+923001234567');
    });

    test('PK accepts already-internationalized form', () {
      final r = Validators.phone(
        raw: '+92 300 1234567',
        regionIso2: 'PK',
        dialCodeByIso: dialMap,
      );
      expect(r.error, isNull);
      expect(r.normalized, '+923001234567');
    });

    test('PK rejects 4-prefix (must start with 3)', () {
      final r = Validators.phone(
        raw: '04001234567',
        regionIso2: 'PK',
        dialCodeByIso: dialMap,
      );
      expect(r.error, isNotNull);
    });

    test('IN accepts 6/7/8/9 prefixes', () {
      for (final prefix in ['6', '7', '8', '9']) {
        final r = Validators.phone(
          raw: '${prefix}999999999',
          regionIso2: 'IN',
          dialCodeByIso: dialMap,
        );
        expect(r.error, isNull, reason: 'IN prefix $prefix should pass');
      }
    });

    test('rejects non-numeric content', () {
      final r = Validators.phone(
        raw: '030-abc-4567',
        regionIso2: 'PK',
        dialCodeByIso: dialMap,
      );
      expect(r.error, isNotNull);
    });

    test('rejects unsupported region', () {
      final r = Validators.phone(
        raw: '5551234567',
        regionIso2: 'ZZ',
        dialCodeByIso: dialMap,
      );
      expect(r.error, isNotNull);
    });

    test('rejects too-short / too-long', () {
      expect(
        Validators.phone(raw: '300', regionIso2: 'PK', dialCodeByIso: dialMap).error,
        isNotNull,
      );
      expect(
        Validators.phone(
          raw: '300123456789',
          regionIso2: 'PK',
          dialCodeByIso: dialMap,
        ).error,
        isNotNull,
      );
    });
  });

  group('Validators.personalName', () {
    test('accepts simple Latin name', () {
      final r = Validators.personalName('Rizwan Zafar');
      expect(r.error, isNull);
      expect(r.normalized, 'Rizwan Zafar');
    });

    test('accepts hyphens and apostrophes', () {
      expect(Validators.personalName("O'Brien").error, isNull);
      expect(Validators.personalName('Anne-Marie').error, isNull);
    });

    test('accepts non-Latin scripts (Urdu, Hindi, Bengali)', () {
      expect(Validators.personalName('رضوان ظفر').error, isNull);
      expect(Validators.personalName('रिज़वान').error, isNull);
      expect(Validators.personalName('রিজওয়ান').error, isNull);
    });

    test('collapses multiple spaces', () {
      final r = Validators.personalName('  Rizwan    Zafar  ');
      expect(r.normalized, 'Rizwan Zafar');
    });

    test('rejects digits', () {
      expect(Validators.personalName('Rizwan2').error, isNotNull);
      expect(Validators.personalName('R1zwan').error, isNotNull);
    });

    test('rejects emojis', () {
      expect(Validators.personalName('Rizwan 🚀').error, isNotNull);
    });

    test('rejects special chars', () {
      for (final bad in const ['Rizwan@Z', 'A_B', 'A.B', 'A!B', 'A#B']) {
        expect(Validators.personalName(bad).error, isNotNull, reason: bad);
      }
    });

    test('rejects too-short', () {
      expect(Validators.personalName('A').error, isNotNull);
    });

    test('rejects too-long (>60)', () {
      expect(Validators.personalName('A' * 61).error, isNotNull);
    });
  });

  group('Validators.budgetAmount', () {
    test('accepts plain integer', () {
      final r = Validators.budgetAmount('80000');
      expect(r.majorAmount, 80000);
      expect(r.error, isNull);
    });

    test('strips comma separators', () {
      expect(Validators.budgetAmount('80,000').majorAmount, 80000);
    });

    test('expands "k"', () {
      expect(Validators.budgetAmount('5k').majorAmount, 5000);
      expect(Validators.budgetAmount('80K').majorAmount, 80000);
    });

    test('expands "lac" / "lakh" / "l"', () {
      expect(Validators.budgetAmount('1.5lac').majorAmount, 150000);
      expect(Validators.budgetAmount('1.5lakh').majorAmount, 150000);
      expect(Validators.budgetAmount('1l').majorAmount, 100000);
    });

    test('expands "cr" / "crore"', () {
      expect(Validators.budgetAmount('2cr').majorAmount, 20000000);
      expect(Validators.budgetAmount('1crore').majorAmount, 10000000);
    });

    test('expands "m" / "million"', () {
      expect(Validators.budgetAmount('5m').majorAmount, 5000000);
      expect(Validators.budgetAmount('1million').majorAmount, 1000000);
    });

    test('rejects non-numeric', () {
      expect(Validators.budgetAmount('abc').error, isNotNull);
    });

    test('rejects zero / negative', () {
      expect(Validators.budgetAmount('0').error, isNotNull);
      expect(Validators.budgetAmount('-5').error, isNotNull);
    });

    test('clarifies on suspiciously large (5000k = 5M)', () {
      // 5000k = 5,000,000 — under the >1B sanity check, accepted.
      expect(Validators.budgetAmount('5000k').majorAmount, 5000000);
    });

    test('clarifies on >1B (likely typo)', () {
      final r = Validators.budgetAmount('5000m'); // 5 billion
      expect(r.majorAmount, isNull);
      expect(r.clarification, isNotNull);
    });

    test('clarifies on too-small (<100)', () {
      final r = Validators.budgetAmount('50');
      expect(r.clarification, isNotNull);
    });
  });
}
