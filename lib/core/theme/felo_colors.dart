import 'package:flutter/material.dart';

abstract final class FeloColors {
  static const Color ink900 = Color(0xFF170D31);
  static const Color ink850 = Color(0xFF20163C);
  static const Color ink800 = Color(0xFF2B2249);
  static const Color ink700 = Color(0xFF3C3359);
  static const Color ink500 = Color(0xFF756F88);
  static const Color ink300 = Color(0xFFC8C2D6);
  static const Color paper0 = Color(0xFFFFFFFF);
  static const Color paper50 = Color(0xFFFEF7FF);
  static const Color paper100 = Color(0xFFF8F1FF);

  static const Color surface = Color(0xFFFEF7FF);
  static const Color surfaceContainerLow = Color(0xFFF8F1FF);
  static const Color surfaceContainer = Color(0xFFF3EAFF);
  static const Color surfaceContainerHigh = Color(0xFFEFE5FF);
  static const Color surfaceContainerHighest = Color(0xFFE9DDFF);
  static const Color outlineVariant = Color(0xFFC9C4D5);

  static const Color lavenderPrimary = Color(0xFF5A48C2);
  static const Color lavenderStrong = Color(0xFF6B55D9);
  static const Color lavenderSoft = Color(0xFFE5DEFF);
  static const Color lavenderMist = Color(0xFFDCD2FF);
  static const Color lavenderMascot = Color(0xFF7B6AE5);
  static const Color sageBase = Color(0xFFD0E4C4);
  static const Color sageText = Color(0xFF4F7F3E);
  static const Color peachBase = Color(0xFFFFD4B8);
  static const Color peachText = Color(0xFFF28B5A);
  static const Color mintBase = Color(0xFFBFEBD8);
  static const Color mintText = Color(0xFF4FB58A);
  static const Color butterBase = Color(0xFFFFE8A3);
  static const Color butterText = Color(0xFFE5B13A);
  static const Color skyBase = Color(0xFFBFE0F5);
  static const Color skyText = Color(0xFF4A9FD4);
  static const Color roseBase = Color(0xFFFFD1DC);
  static const Color roseText = Color(0xFFE67A99);

  static const Color feloiBlue = lavenderStrong;
  static const Color skyBlue = skyText;
  static const Color feloiTeal = lavenderPrimary;
  static const Color mintGreen = mintText;
  static const Color forestGreen = sageText;
  static const Color royalPurple = lavenderMascot;
  static const Color signalGold = butterText;
  static const Color signalAmber = Color(0xFFD8961F);
  static const Color signalRose = roseText;
  static const Color signalCrimson = Color(0xFFD6455D);

  /// Felo brand mark gradient — used by the splash screen and any
  /// hero "F" mark surface. Light theme.
  static const LinearGradient feloMarkGradient = LinearGradient(
    colors: [feloiBlue, skyBlue, feloiTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Felo brand mark gradient — dark theme variant. Slightly deeper
  /// stops to maintain perceived contrast against a dark background.
  static const LinearGradient feloMarkGradientDark = LinearGradient(
    colors: [lavenderPrimary, lavenderMascot, feloiTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
