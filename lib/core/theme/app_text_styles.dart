import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Clean typography styles for the 11FIT athletic app.
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle brandLogo = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle heroHeading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.8,
    color: AppColors.textPrimary,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const TextStyle productTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle priceCurrent = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const TextStyle priceOriginal = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough,
    decorationColor: AppColors.textMuted,
    color: AppColors.textMuted,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
    color: AppColors.textOnLime,
  );

  static const TextStyle badgeText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.4,
    color: AppColors.textOnLime,
  );
}
