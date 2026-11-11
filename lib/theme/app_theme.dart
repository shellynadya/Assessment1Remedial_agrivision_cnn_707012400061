import 'package:flutter/material.dart';

class AppTheme {
  static const Color hijauUtama = Color(0xFF356B3B);

  static ThemeData get lightTheme {
    final warna = ColorScheme.fromSeed(
      seedColor: hijauUtama,
      brightness: Brightness.light,
      surface: const Color(0xFFFAF9F2),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: warna,
      scaffoldBackgroundColor: warna.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: warna.surface,
        foregroundColor: warna.onSurface,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        color: warna.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final warna = ColorScheme.fromSeed(
      seedColor: hijauUtama,
      brightness: Brightness.dark,
      surface: const Color(0xFF111B16),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: warna,
      scaffoldBackgroundColor: warna.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: warna.surface,
        foregroundColor: warna.onSurface,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        color: warna.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
