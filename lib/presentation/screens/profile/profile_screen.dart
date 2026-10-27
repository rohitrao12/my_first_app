import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../logic/navigation/navigation_cubit.dart';
import '../brand/brand_story_screen.dart';
import 'widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: AppColors.cardElevated,
                  content: Text('Settings opened'),
                ),
              );
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
                    color: AppColors.cardElevated,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.limeAccent, width: 2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_rounded,
                      size: 36,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rohit Rao',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'rohitrao@gmail.com',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Profile Options Menu
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
              textColor: AppColors.textSecondary,
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
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
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
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceOverlay,
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

  void _showOrdersModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recent Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.check_circle_outline, color: AppColors.limeAccent),
                  title: const Text('Order #11FIT-8923 (Delivered)', style: TextStyle(color: AppColors.textPrimary)),
                  subtitle: const Text('4-Way Stretch Gym Shorts • ₹499', style: TextStyle(color: AppColors.textSecondary)),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
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
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              SizedBox(height: 12),
              Text(
                'Rohit Rao (Home)\nFlat 402, Elite Heights, Andheri West\nMumbai, Maharashtra, 400001\nPhone: +91 98765 43210',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showCouponsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Coupons',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.limeAccent),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('11FIT40', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.limeAccent)),
                        Text('Flat ₹400 off on orders above ₹1,000', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                    Text('ACTIVE', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.limeAccent)),
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
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '24/7 Support',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              SizedBox(height: 12),
              Text(
                'Email: support@11fit.in\nPhone: 1800-11-3487 (Toll Free)\nChat: Available Mon-Sat (9 AM - 9 PM)',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.6),
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          title: const Text('Log Out', style: TextStyle(color: AppColors.textPrimary)),
          content: const Text('Are you sure you want to log out from 11FIT?', style: TextStyle(color: AppColors.textSecondary)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.cardElevated,
                    content: Text('Logged out successfully'),
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
