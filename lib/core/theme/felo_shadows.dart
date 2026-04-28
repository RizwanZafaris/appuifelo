import 'package:flutter/widgets.dart';

import 'package:felo/core/theme/felo_colors.dart';

/// Elevation / shadow design tokens.
///
/// Three steps map to the existing visual language:
///   sm (alpha 0.08, blur 24, y 8) — resting cards
///   md (alpha 0.12, blur 28, y 10) — floating nav, sheets
///   lg (alpha 0.16, blur 24, y 8) — primary CTAs / hero affordances
///
/// All shadows use [FeloColors.lavenderMascot] as the tint for visual
/// continuity with the brand mark.
abstract final class FeloShadows {
  static const double alphaSm = 0.08;
  static const double alphaMd = 0.12;
  static const double alphaLg = 0.16;

  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x147B6AE5), // lavenderMascot @ 0.08
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x1F7B6AE5), // lavenderMascot @ 0.12
      blurRadius: 28,
      offset: Offset(0, 10),
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x297B6AE5), // lavenderMascot @ 0.16
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];
}
