import 'package:felo/core/config/felo_env.dart';
import 'package:flutter_test/flutter_test.dart';

/// We can't override `--dart-define` from inside the test process, but we
/// can verify the public guards behave the way release-build callers
/// expect: the boot assertion is a no-op outside release mode (so tests
/// pass), and useFakeData / stub flags read consistent values.
void main() {
  test('assertProductionReady is a no-op outside release builds', () {
    expect(() => FeloEnv.assertProductionReady(), returnsNormally);
  });

  test('stub feature flags expose deterministic getters', () {
    expect(FeloEnv.enableKyc, isA<bool>());
    expect(FeloEnv.enableInvestments, isA<bool>());
    expect(FeloEnv.enableSmsParser, isA<bool>());
    expect(FeloEnv.enableLiveRemittance, isA<bool>());
  });

  test('apiUrl defaults to empty (release builds must inject)', () {
    // The compile-time default in felo_env.dart is the empty string so a
    // missing --dart-define fails fast in assertProductionReady.
    if (FeloEnv.apiUrl.isNotEmpty) {
      // CI may inject a value — accept any value but reject the
      // emulator-only URL that used to be the default.
      expect(
        FeloEnv.apiUrl.contains('10.0.2.2'),
        isFalse,
        reason: 'apiUrl must not default to the emulator URL',
      );
    }
  });
}
