import 'package:flutter/material.dart';

/// Kirya brand palette.
///
/// Derived from the Kirya app logo: luxury black, gold and teal/mint accents on
/// a clean white background. These constants are the single source of truth for
/// colour across the landing page, admin CMS and checkout pages.
class AppColors {
  AppColors._();

  // Core brand
  static const Color deepBlack = Color(0xFF0E0E0D);
  static const Color charcoalBlack = Color(0xFF1A1A18);
  static const Color luxuryGold = Color(0xFFCAAE65);
  static const Color softGold = Color(0xFFE6D89A);
  static const Color darkGold = Color(0xFFA5955D);
  static const Color tealGreen = Color(0xFF5C998D);
  static const Color deepTeal = Color(0xFF315451);
  static const Color softMint = Color(0xFFAAD0AD);
  static const Color lightGrey = Color(0xFFEDEDED);
  static const Color whiteBackground = Color(0xFFFCFCFC);

  // Semantic roles
  static const Color primary = deepBlack;
  static const Color secondary = tealGreen;
  static const Color accent = luxuryGold;
  static const Color background = whiteBackground;
  static const Color surface = Color(0xFFFFFFFF);
  static const Color darkSurface = charcoalBlack;
  static const Color textDark = deepBlack;
  static const Color textMuted = Color(0xFF9FA19E);
  static const Color success = tealGreen;
  static const Color premium = luxuryGold;
  static const Color warning = Color(0xFFE0A458);
  static const Color danger = Color(0xFFC0564B);

  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [softGold, luxuryGold, darkGold],
  );

  static const LinearGradient tealGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [tealGreen, deepTeal],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [charcoalBlack, deepBlack],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFCFCFC), Color(0xFFF2F2EF)],
  );

  /// Glassmorphism overlay colour for cards layered on dark surfaces.
  static Color glassOverlay = Colors.white.withValues(alpha: 0.06);
  static Color glassBorder = Colors.white.withValues(alpha: 0.12);
}
