import 'package:flutter/material.dart';

/// App color palette matching the 11FIT athletic aesthetic with support for both
/// vibrant Dark and crisp White/Light themes.
class AppColors {
  AppColors._();

  // Primary Accent (Vibrant Electric Lime / Neon Yellow-Green)
  static const Color limeAccent = Color(0xFFCEFF00);
  static const Color limeAccentDark = Color(0xFF90BD00);
  static const Color limeAccentHover = Color(0xFFB8E600);
  static const Color limeLight = Color(0xFFE5FF7F);
  static const Color limeMuted = Color(0x33CEFF00);

  // Dark Theme Backgrounds & Cards
  static const Color background = Color(0xFF0D0D0E);
  static const Color backgroundSecondary = Color(0xFF141517);
  static const Color cardBackground = Color(0xFF1A1B1E);
  static const Color cardElevated = Color(0xFF222428);
  static const Color surfaceOverlay = Color(0x80000000);

  // Dark Theme Borders & Typography
  static const Color border = Color(0xFF282A2F);
  static const Color borderLight = Color(0xFF383A42);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textMuted = Color(0xFF71717A);

  // Light (White) Theme Backgrounds & Cards
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightBackgroundSecondary = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardElevated = Color(0xFFF3F4F6);
  static const Color lightSurfaceOverlay = Color(0x1A000000);

  // Light Theme Borders & Typography
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightBorderStrong = Color(0xFFD1D5DB);
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF4B5563);
  static const Color lightTextMuted = Color(0xFF9CA3AF);

  // Common Text on Accent
  static const Color textOnLime = Color(0xFF000000);

  // Status & Utility Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFFF453A);
  static const Color starRating = Color(0xFFFFB800);
  static const Color discountBadge = Color(0xFFCEFF00);

  // Color Swatches for Products
  static const Color productBlack = Color(0xFF1C1C1E);
  static const Color productOlive = Color(0xFF4B5320);
  static const Color productGrey = Color(0xFF8E8E93);
  static const Color productNavy = Color(0xFF1E293B);
}

/// Convenience extensions on [BuildContext] to get the active theme colors automatically
extension ThemeContext on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get appBackground =>
      isDarkMode ? AppColors.background : AppColors.lightBackground;

  Color get appBackgroundSecondary =>
      isDarkMode ? AppColors.backgroundSecondary : AppColors.lightBackgroundSecondary;

  Color get appCard =>
      isDarkMode ? AppColors.cardBackground : AppColors.lightCard;

  Color get appCardElevated =>
      isDarkMode ? AppColors.cardElevated : AppColors.lightCardElevated;

  Color get appBorder =>
      isDarkMode ? AppColors.border : AppColors.lightBorder;

  Color get appTextPrimary =>
      isDarkMode ? AppColors.textPrimary : AppColors.lightTextPrimary;

  Color get appTextSecondary =>
      isDarkMode ? AppColors.textSecondary : AppColors.lightTextSecondary;

  Color get appTextMuted =>
      isDarkMode ? AppColors.textMuted : AppColors.lightTextMuted;
}
