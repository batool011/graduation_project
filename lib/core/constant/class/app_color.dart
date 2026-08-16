import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {
  // ── Brand (Light Mode) ──────────────────────────────────────────────
  // A vivid, modern indigo - deeper and richer than the old muted
  // blue-purple, chosen to match the gradient direction already used
  // consistently across the redesigned screens (Courses, Overtime,
  // Payroll, Tasks): a deep indigo anchor with a lighter indigo glow and
  // a cyan companion for energy/contrast.
  static const primaryColor = Color(0xFF4F46E5); // Indigo 600
  static const primaryLight = Color(0xFF818CF8); // Indigo 400 - gradient glow / hover tints
  static const primaryDark = Color(0xFF3730A3); // Indigo 800 - gradient anchor / shadows
  static const accentColor = Color(0xFF06B6D4); // Cyan 500 - energetic companion accent
  static const secondryColor = Color(0xFFF59E0B); // Amber 500 - warm highlight/CTA accent

  // Semantic colors - formalizing hex values that were already being
  // hand-typed all over the app (0xFF16A34A, 0xFFDC2626, 0xFF2563EB...)
  // so every screen pulls from the same source instead of each re-typing
  // a slightly different shade.
  static const successColor = Color(0xFF16A34A);
  static const warningColor = Color(0xFFF59E0B);
  static const infoColor = Color(0xFF2563EB);

  static const lightWhite = Color(0xFFFAFAFA);
  static const lightGrey = Color(0xFFF6F9F8);
  static const darkGrey = Color.fromARGB(255, 191, 188, 188);
  static const grey = Color(0xFFEDEAE4);
  static const lightBlackLight = Color(0xFF484848);
  static const lightScaffoldColor = Color(0xFFF7F9F8);
  static const lightBlack = Colors.black;
  static const errorColor = Color(0xFFDC2626);
  static const green = Color(0xFF16A34A);
  static const orange = Color(0xFFF59E0B);
  static const blue = Color(0xFF2563EB);

  // ── Dark Mode ────────────────────────────────────────────────────────
  static const darkPrimaryColor = Color(0xFF6366F1); // Indigo 500 - pops on dark backgrounds
  static const darkBackgroundColor = Color(0xFF121212);
  static const darkSurfaceColor = Color(0xFF1E1E1E);
  static const darkSecondaryColor = Color(0xFFF59E0B);
  static const darkTextColor = Color(0xFFE0E0E0);
  static const darkTextSecondaryColor = Color(0xFFB0B0B0);

  static Color get white => Get.isDarkMode ? darkSurfaceColor : lightWhite;
  static Color get scaffoldColor =>
      Get.isDarkMode ? darkBackgroundColor : lightScaffoldColor;
  static Color get black => Get.isDarkMode ? darkTextColor : lightBlack;
  static Color get blackLight =>
      Get.isDarkMode ? darkTextSecondaryColor : lightBlackLight;

  /// The one canonical "hero" gradient - deep indigo to a light indigo
  /// glow. Every hero header (Home banner, Courses, Overtime, Payroll,
  /// Tasks...) should use this instead of hand-rolling its own slightly
  /// different indigo gradient, so the whole app reads as one product.
  static LinearGradient heroGradient({
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(colors: const [primaryDark, primaryColor, primaryLight], begin: begin, end: end);
  }

  /// Secondary gradient for CTA buttons / highlighted actions - indigo
  /// into the cyan accent, giving a bit more energy than the flat brand
  /// color alone.
  static LinearGradient actionGradient({
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
  }) {
    return LinearGradient(colors: const [primaryColor, accentColor], begin: begin, end: end);
  }
}
