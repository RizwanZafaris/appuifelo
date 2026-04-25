import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';

abstract final class FeloTheme {
  static ThemeData light() {
    const colorScheme = ColorScheme.light(
      primary: FeloColors.lavenderPrimary,
      onPrimary: Colors.white,
      primaryContainer: FeloColors.lavenderSoft,
      onPrimaryContainer: FeloColors.ink900,
      secondary: FeloColors.mintText,
      onSecondary: Colors.white,
      secondaryContainer: FeloColors.mintBase,
      onSecondaryContainer: FeloColors.ink900,
      tertiary: FeloColors.peachText,
      onTertiary: Colors.white,
      tertiaryContainer: FeloColors.peachBase,
      onTertiaryContainer: FeloColors.ink900,
      error: FeloColors.signalCrimson,
      surface: FeloColors.surface,
      onSurface: FeloColors.ink900,
      onSurfaceVariant: FeloColors.ink500,
      outline: FeloColors.outlineVariant,
      outlineVariant: FeloColors.outlineVariant,
      surfaceContainerLowest: FeloColors.paper0,
      surfaceContainerLow: FeloColors.surfaceContainerLow,
      surfaceContainer: FeloColors.surfaceContainer,
      surfaceContainerHigh: FeloColors.surfaceContainerHigh,
      surfaceContainerHighest: FeloColors.surfaceContainerHighest,
    );
    return _base(colorScheme).copyWith(
      scaffoldBackgroundColor: FeloColors.surface,
      cardColor: FeloColors.paper0,
    );
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: FeloColors.feloiTeal,
      brightness: Brightness.dark,
    );
    return _base(colorScheme).copyWith(
      scaffoldBackgroundColor: FeloColors.ink900,
      cardColor: FeloColors.ink800,
    );
  }

  static ThemeData _base(ColorScheme colorScheme) {
    final baseTextTheme = colorScheme.brightness == Brightness.dark
        ? Typography.material2021().white
        : Typography.material2021().black;
    final textTheme = baseTextTheme.apply(
      fontFamily: 'Inter',
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        foregroundColor: colorScheme.onSurface,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: FeloColors.lavenderPrimary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
