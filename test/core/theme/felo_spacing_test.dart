import 'package:flutter_test/flutter_test.dart';
import 'package:felo/core/theme/felo_spacing.dart';

void main() {
  group('FeloSpacing.minTapTarget', () {
    test('meets WCAG 2.1 AA minimum touch target of 48dp', () {
      expect(FeloSpacing.minTapTarget, greaterThanOrEqualTo(48));
    });

    test('is exactly 48dp', () {
      expect(FeloSpacing.minTapTarget, 48);
    });
  });
}
