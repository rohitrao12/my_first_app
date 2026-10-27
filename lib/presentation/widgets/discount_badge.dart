import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class DiscountBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;

  const DiscountBadge({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.limeAccent,
    this.textColor = AppColors.textOnLime,
    this.padding = const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.badgeText.copyWith(color: textColor),
      ),
    );
  }
}
