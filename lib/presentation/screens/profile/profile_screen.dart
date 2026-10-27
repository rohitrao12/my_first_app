import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../logic/navigation/navigation_cubit.dart';
import '../../../logic/theme/theme_cubit.dart';
import '../brand/brand_story_screen.dart';
import 'widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appBackground,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: context.appTextPrimary,
          ),
        ),
        actions: [
          // Theme quick toggle in AppBar
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_outlined,
              color: isDark ? AppColors.limeAccent : context.appTextPrimary,
            ),
            tooltip: isDark ? 'Switch to Light (White) Theme' : 'Switch to Dark Theme',
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined, color: context.appTextPrimary),
            tooltip: 'Settings',
            onPressed: () {
              _showThemeSettingsModal(context);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // User Profile Header: Avatar + Rohit Rao + rohitrao@gmail.com
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: context.appCardElevated,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? AppColors.limeAccent : AppColors.limeAccentDark,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_rounded,
                      size: 36,
                      color: context.appTextPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rohit Rao',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.appTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'rohitrao@gmail.com',
                      style: TextStyle(
                        fontSize: 13,
                        color: context.appTextSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Profile Options Menu with Theme Switch
            ProfileMenuItem(
              icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              iconColor: isDark ? AppColors.limeAccent : AppColors.starRating,
              title: isDark ? 'Dark Theme' : 'Light (White) Theme',
              trailing: Switch.adaptive(
                value: isDark,
                activeThumbColor: AppColors.limeAccent,
                activeTrackColor: const Color(0xFF2E331A),
                onChanged: (val) {
                  context.read<ThemeCubit>().toggleTheme();
                },
              ),
              onTap: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),

            ProfileMenuItem(
              icon: Icons.receipt_long_outlined,
              title: 'My Orders',
              onTap: () {
                _showOrdersModal(context);
              },
            ),
            ProfileMenuItem(
              icon: Icons.location_on_outlined,
              title: 'Address Book',
              onTap: () {
                _showAddressModal(context);
              },
            ),
            ProfileMenuItem(
              icon: Icons.favorite_border_rounded,
              title: 'Wishlist',
              onTap: () {
                context.read<NavigationCubit>().setTab(2);
              },
            ),
            ProfileMenuItem(
              icon: Icons.local_offer_outlined,
              title: 'Coupons & Offers',
              onTap: () {
                _showCouponsModal(context);
              },
            ),
            ProfileMenuItem(
              icon: Icons.help_outline_rounded,
              title: 'Help & Support',
              onTap: () {
                _showHelpModal(context);
              },
            ),
            ProfileMenuItem(
              icon: Icons.info_outline_rounded,
              title: 'About 11FIT',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const BrandStoryScreen(),
                  ),
                );
              },
            ),
            ProfileMenuItem(
              icon: Icons.logout_rounded,
              title: 'Log Out',
              textColor: context.appTextSecondary,
              onTap: () {
                _showLogoutDialog(context);
              },
            ),

            const SizedBox(height: 16),

            // "STAY FIT STAY AHEAD" Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: isDark ? context.appCard : const Color(0xFF141517),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.appBorder),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF141517),
                    Color(0xFF1F2228),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STAY FIT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: AppColors.limeAccent,
                        ),
                      ),
                      Text(
                        'STAY AHEAD',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: const Text(
                          '11FIT',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            color: AppColors.limeAccent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.directions_run_rounded,
                        color: AppColors.limeAccent,
                        size: 32,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showThemeSettingsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.appCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, currentMode) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appearance & Theme',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ctx.appTextPrimary,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: ctx.appTextSecondary),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  Divider(color: ctx.appBorder),
                  ListTile(
                    leading: const Icon(Icons.light_mode_outlined, color: AppColors.starRating),
                    title: Text('White (Light) Theme', style: TextStyle(color: ctx.appTextPrimary, fontWeight: FontWeight.w600)),
                    subtitle: Text('Clean modern white aesthetic', style: TextStyle(color: ctx.appTextSecondary, fontSize: 12)),
                    trailing: currentMode == ThemeMode.light
                        ? const Icon(Icons.check_circle_rounded, color: AppColors.limeAccentDark)
                        : null,
                    onTap: () {
                      context.read<ThemeCubit>().setTheme(ThemeMode.light);
                      Navigator.pop(ctx);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.dark_mode_outlined, color: AppColors.limeAccent),
                    title: Text('Dark Theme', style: TextStyle(color: ctx.appTextPrimary, fontWeight: FontWeight.w600)),
                    subtitle: Text('Matte black aesthetic from original designs', style: TextStyle(color: ctx.appTextSecondary, fontSize: 12)),
                    trailing: currentMode == ThemeMode.dark
                        ? const Icon(Icons.check_circle_rounded, color: AppColors.limeAccent)
                        : null,
                    onTap: () {
                      context.read<ThemeCubit>().setTheme(ThemeMode.dark);
                      Navigator.pop(ctx);
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showOrdersModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.appCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ctx.appTextPrimary),
              ),
              const SizedBox(height: 16),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.check_circle_outline,
                    color: ctx.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                  ),
                  title: Text('Order #11FIT-8923 (Delivered)', style: TextStyle(color: ctx.appTextPrimary)),
                  subtitle: Text('4-Way Stretch Gym Shorts • ₹499', style: TextStyle(color: ctx.appTextSecondary)),
                  trailing: Icon(Icons.chevron_right, color: ctx.appTextSecondary),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _showAddressModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.appCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ctx.appTextPrimary),
              ),
              const SizedBox(height: 12),
              Text(
                'Rohit Rao (Home)\nFlat 402, Elite Heights, Andheri West\nMumbai, Maharashtra, 400001\nPhone: +91 98765 43210',
                style: TextStyle(fontSize: 14, color: ctx.appTextSecondary, height: 1.5),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showCouponsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.appCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Coupons',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ctx.appTextPrimary),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ctx.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '11FIT40',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ctx.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                          ),
                        ),
                        Text('Flat ₹400 off on orders above ₹1,000', style: TextStyle(fontSize: 12, color: ctx.appTextSecondary)),
                      ],
                    ),
                    Text(
                      'ACTIVE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ctx.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showHelpModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.appCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '24/7 Support',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ctx.appTextPrimary),
              ),
              const SizedBox(height: 12),
              Text(
                'Email: support@11fit.in\nPhone: 1800-11-3487 (Toll Free)\nChat: Available Mon-Sat (9 AM - 9 PM)',
                style: TextStyle(fontSize: 14, color: ctx.appTextSecondary, height: 1.6),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: ctx.appCard,
          title: Text('Log Out', style: TextStyle(color: ctx.appTextPrimary)),
          content: Text('Are you sure you want to log out from 11FIT?', style: TextStyle(color: ctx.appTextSecondary)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel', style: TextStyle(color: ctx.appTextSecondary)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: context.appCardElevated,
                    content: Text('Logged out successfully', style: TextStyle(color: context.appTextPrimary)),
                  ),
                );
              },
              child: const Text('Log Out', style: TextStyle(color: AppColors.error)),
            ),
          ],
        );
      },
    );
  }
}
