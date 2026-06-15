import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Builds the global [ThemeData] for Kirya.
///
/// The brand uses a light SaaS surface with black luxury cards and gold/teal
/// accents. Typography uses Poppins for headings and Inter for body copy.
class AppTheme {
  AppTheme._();

  static const double radiusSm = 10;
  static const double radiusMd = 16;
  static const double radiusLg = 24;
  static const double radiusXl = 32;

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);

    final colorScheme = const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      tertiary: AppColors.accent,
      onTertiary: AppColors.deepBlack,
      surface: AppColors.surface,
      onSurface: AppColors.textDark,
      error: AppColors.danger,
      onError: Colors.white,
    );

    final textTheme = _buildTextTheme(base.textTheme, AppColors.textDark);

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,
      splashColor: AppColors.tealGreen.withValues(alpha: 0.08),
      highlightColor: AppColors.tealGreen.withValues(alpha: 0.04),
      dividerColor: AppColors.lightGrey,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.textDark,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: _inputBorder(AppColors.lightGrey),
        enabledBorder: _inputBorder(AppColors.lightGrey),
        focusedBorder: _inputBorder(AppColors.tealGreen, width: 1.6),
        errorBorder: _inputBorder(AppColors.danger),
        focusedErrorBorder: _inputBorder(AppColors.danger, width: 1.6),
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        labelStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.tealGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.tealGreen,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.charcoalBlack,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.charcoalBlack,
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base, Color color) {
    final heading = GoogleFonts.poppinsTextTheme(base);
    final body = GoogleFonts.interTextTheme(base);
    return base.copyWith(
      displayLarge: heading.displayLarge
          ?.copyWith(color: color, fontWeight: FontWeight.w700, height: 1.05),
      displayMedium: heading.displayMedium
          ?.copyWith(color: color, fontWeight: FontWeight.w700, height: 1.08),
      displaySmall: heading.displaySmall
          ?.copyWith(color: color, fontWeight: FontWeight.w600),
      headlineLarge: heading.headlineLarge
          ?.copyWith(color: color, fontWeight: FontWeight.w700),
      headlineMedium: heading.headlineMedium
          ?.copyWith(color: color, fontWeight: FontWeight.w600),
      headlineSmall: heading.headlineSmall
          ?.copyWith(color: color, fontWeight: FontWeight.w600),
      titleLarge: heading.titleLarge
          ?.copyWith(color: color, fontWeight: FontWeight.w600),
      titleMedium: body.titleMedium
          ?.copyWith(color: color, fontWeight: FontWeight.w600),
      titleSmall:
          body.titleSmall?.copyWith(color: color, fontWeight: FontWeight.w600),
      bodyLarge: body.bodyLarge?.copyWith(color: color, height: 1.6),
      bodyMedium: body.bodyMedium?.copyWith(color: color, height: 1.55),
      bodySmall: body.bodySmall?.copyWith(color: AppColors.textMuted),
      labelLarge: body.labelLarge
          ?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.2),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
