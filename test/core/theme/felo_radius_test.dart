import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/theme/felo_radius.dart';

void main() {
  group('FeloCornerRadius', () {
    test('scale: sm < md < lg', () {
      expect(FeloCornerRadius.sm < FeloCornerRadius.md, isTrue);
      expect(FeloCornerRadius.md < FeloCornerRadius.lg, isTrue);
    });

    test('canonical values: 12 / 20 / 28', () {
      expect(FeloCornerRadius.sm, 12);
      expect(FeloCornerRadius.md, 20);
      expect(FeloCornerRadius.lg, 28);
    });

    test('BorderRadius getters use the matching numeric value', () {
      expect(
        FeloCornerRadius.smAll,
        BorderRadius.circular(FeloCornerRadius.sm),
      );
      expect(
        FeloCornerRadius.mdAll,
        BorderRadius.circular(FeloCornerRadius.md),
      );
      expect(
        FeloCornerRadius.lgAll,
        BorderRadius.circular(FeloCornerRadius.lg),
      );
    });
  });
}
