import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/theme/felo_colors.dart';

void main() {
  group('FeloColors.feloMarkGradient', () {
    test('light variant uses brand stops in topLeft → bottomRight', () {
      const g = FeloColors.feloMarkGradient;
      expect(g.colors, [
        FeloColors.feloiBlue,
        FeloColors.skyBlue,
        FeloColors.feloiTeal,
      ]);
      expect(g.begin, Alignment.topLeft);
      expect(g.end, Alignment.bottomRight);
    });

    test('dark variant exists, is distinct, and shares direction', () {
      const dark = FeloColors.feloMarkGradientDark;
      expect(dark.colors.length, 3);
      expect(dark.colors, isNot(equals(FeloColors.feloMarkGradient.colors)));
      expect(dark.begin, Alignment.topLeft);
      expect(dark.end, Alignment.bottomRight);
    });
  });
}
