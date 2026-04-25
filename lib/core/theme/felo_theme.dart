import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';

abstract final class FeloTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: FeloColors.feloiTeal,
      brightness: Brightness.light,
    );
    return _base(colorScheme).copyWith(
      scaffoldBackgroundColor: FeloColors.paper50,
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
    final textTheme = Typography.material2021().white.apply(
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
        selectedItemColor: FeloColors.feloiTeal,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: FeloColors.feloiTeal, width: 2),
        ),
      ),
    );
  }
}
