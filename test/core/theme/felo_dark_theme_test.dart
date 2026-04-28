import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/core/theme/felo_theme.dart';

double _luminance(Color c) {
  double channel(int v) {
    final s = v / 255.0;
    return s <= 0.03928 ? s / 12.92 : math.pow((s + 0.055) / 1.055, 2.4).toDouble();
  }

  final argb = c.toARGB32();
  final r = (argb >> 16) & 0xFF;
  final g = (argb >> 8) & 0xFF;
  final b = argb & 0xFF;
  return 0.2126 * channel(r) + 0.7152 * channel(g) + 0.0722 * channel(b);
}

double _contrast(Color a, Color b) {
  final la = _luminance(a) + 0.05;
  final lb = _luminance(b) + 0.05;
  return la > lb ? la / lb : lb / la;
}

void main() {
  final theme = FeloTheme.dark();
  final scheme = theme.colorScheme;

  group('FeloTheme.dark — explicit ColorScheme overrides', () {
    test('brightness is dark', () {
      expect(scheme.brightness, Brightness.dark);
    });

    test('semantic anchors map to FeloColors (no fromSeed drift)', () {
      expect(scheme.primary, FeloColors.lavenderSoft);
      expect(scheme.secondary, FeloColors.mintBase);
      expect(scheme.tertiary, FeloColors.peachBase);
      expect(scheme.error, FeloColors.roseBase);
      expect(scheme.surface, FeloColors.ink900);
    });

    test('on* foreground pairs meet WCAG AA (≥ 4.5:1)', () {
      expect(_contrast(scheme.onSurface, scheme.surface),
          greaterThanOrEqualTo(4.5));
      expect(_contrast(scheme.onPrimary, scheme.primary),
          greaterThanOrEqualTo(4.5));
      expect(_contrast(scheme.onSecondary, scheme.secondary),
          greaterThanOrEqualTo(4.5));
      expect(_contrast(scheme.onTertiary, scheme.tertiary),
          greaterThanOrEqualTo(4.5));
      expect(_contrast(scheme.onError, scheme.error),
          greaterThanOrEqualTo(4.5));
    });
  });
}
