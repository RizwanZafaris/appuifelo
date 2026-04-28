import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/core/theme/felo_shadows.dart';

void main() {
  group('FeloShadows', () {
    test('alpha scale: sm < md < lg', () {
      expect(FeloShadows.alphaSm < FeloShadows.alphaMd, isTrue);
      expect(FeloShadows.alphaMd < FeloShadows.alphaLg, isTrue);
    });

    test('canonical alpha values', () {
      expect(FeloShadows.alphaSm, 0.08);
      expect(FeloShadows.alphaMd, 0.12);
      expect(FeloShadows.alphaLg, 0.16);
    });

    test('shadow color matches lavenderMascot RGB at the listed alpha', () {
      const mascotRgb = 0x7B6AE5;
      for (final entry in {
        FeloShadows.sm.first: FeloShadows.alphaSm,
        FeloShadows.md.first: FeloShadows.alphaMd,
        FeloShadows.lg.first: FeloShadows.alphaLg,
      }.entries) {
        final BoxShadow shadow = entry.key;
        final double alpha = entry.value;
        final int rgb = shadow.color.toARGB32() & 0x00FFFFFF;
        final int alphaByte = (shadow.color.toARGB32() >> 24) & 0xFF;
        expect(rgb, mascotRgb,
            reason: 'shadow tint should equal lavenderMascot RGB');
        expect(alphaByte, (alpha * 255).round());
        expect(FeloColors.lavenderMascot.toARGB32() & 0x00FFFFFF, mascotRgb);
      }
    });

    test('shadows are exposed as const lists (single shadow each)', () {
      expect(FeloShadows.sm.length, 1);
      expect(FeloShadows.md.length, 1);
      expect(FeloShadows.lg.length, 1);
    });
  });
}
