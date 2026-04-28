import 'package:flutter/widgets.dart';

/// Corner-radius design tokens.
///
/// Use the `BorderRadius` getters in widgets so radii stay consistent
/// across the app. Raw `BorderRadius.circular(...)` calls inside widgets
/// are an anti-pattern — add a token here instead.
abstract final class FeloCornerRadius {
  /// Small — chips, inputs, tight badges.
  static const double sm = 12;

  /// Medium — cards, buttons (default surface radius).
  static const double md = 20;

  /// Large — sheets, navigation containers, hero surfaces.
  static const double lg = 28;

  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
}
