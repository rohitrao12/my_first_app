import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  final Widget? trailing;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: context.appCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: context.appBorder),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: context.isDarkMode ? 0 : 0.5,
        shadowColor: Colors.black.withValues(alpha: 0.04),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          leading: Icon(
            icon,
            color: iconColor ?? context.appTextSecondary,
            size: 22,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor ?? context.appTextPrimary,
            ),
          ),
          trailing: trailing ??
              Icon(
                Icons.chevron_right_rounded,
                color: context.appTextSecondary,
                size: 20,
              ),
          onTap: onTap,
        ),
      ),
    );
  }
}
