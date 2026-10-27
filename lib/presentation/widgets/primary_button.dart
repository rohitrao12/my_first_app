import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool showArrow;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double? width;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Widget? leading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.showArrow = false,
    this.backgroundColor = AppColors.limeAccent,
    this.textColor = AppColors.textOnLime,
    this.height = 48,
    this.width,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.borderRadius = 8,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: AppTextStyles.buttonText.copyWith(
                color: textColor,
                fontSize: height < 40 ? 12 : 14,
              ),
            ),
            if (showArrow) ...[
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_forward_rounded,
                size: height < 40 ? 14 : 18,
                color: textColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
