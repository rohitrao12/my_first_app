import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../logic/navigation/navigation_cubit.dart';
import 'categories/categories_screen.dart';
import 'home/home_screen.dart';
import 'profile/profile_screen.dart';
import 'wishlist/wishlist_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    CategoriesScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final activeColor = isDark ? AppColors.limeAccent : AppColors.lightTextPrimary;

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, activeIndex) {
        return Scaffold(
          backgroundColor: context.appBackground,
          body: IndexedStack(
            index: activeIndex,
            children: _screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: context.appBackgroundSecondary,
              border: Border(
                top: BorderSide(
                  color: context.appBorder,
                  width: 1,
                ),
              ),
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
            ),
            child: BottomNavigationBar(
              currentIndex: activeIndex,
              onTap: (index) {
                context.read<NavigationCubit>().setTab(index);
              },
              backgroundColor: context.appBackgroundSecondary,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: activeColor,
              unselectedItemColor: context.appTextSecondary,
              selectedFontSize: 11,
              unselectedFontSize: 11,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.home_outlined),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.home_rounded, color: activeColor),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.grid_view_outlined),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.grid_view_rounded, color: activeColor),
                  ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.favorite_border_rounded),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.favorite_rounded, color: activeColor),
                  ),
                  label: 'Wishlist',
                ),
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.person_outline_rounded),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.person_rounded, color: activeColor),
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
