import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../logic/cart/cart_bloc.dart';
import '../../logic/cart/cart_state.dart';
import '../../logic/navigation/navigation_cubit.dart';
import '../../logic/theme/theme_cubit.dart';
import '../../logic/wishlist/wishlist_bloc.dart';
import '../../logic/wishlist/wishlist_state.dart';
import '../screens/cart/cart_screen.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool showActions;
  final VoidCallback? onSearchPressed;

  const AppHeader({
    super.key,
    this.showActions = true,
    this.onSearchPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.appBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              '11FIT',
              style: AppTextStyles.brandLogo.copyWith(
                color: context.appTextPrimary,
              ),
            ),
          ),
        ],
      ),
      actions: showActions
          ? [
              // Theme Toggle Action Button (Light / Dark mode)
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  final isDark = themeMode == ThemeMode.dark;
                  return IconButton(
                    icon: Icon(
                      isDark ? Icons.light_mode_rounded : Icons.dark_mode_outlined,
                      color: isDark ? AppColors.limeAccent : context.appTextPrimary,
                      size: 22,
                    ),
                    tooltip: isDark ? 'Switch to Light (White) Theme' : 'Switch to Dark Theme',
                    onPressed: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.search_rounded,
                  color: context.appTextPrimary,
                  size: 24,
                ),
                tooltip: 'Search',
                onPressed: () {
                  if (onSearchPressed != null) {
                    onSearchPressed!();
                  } else {
                    // Switch to categories/products search
                    context.read<NavigationCubit>().setTab(1);
                  }
                },
              ),
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border_rounded,
                          color: context.appTextPrimary,
                          size: 24,
                        ),
                        tooltip: 'Wishlist',
                        onPressed: () {
                          context.read<NavigationCubit>().setTab(2);
                        },
                      ),
                      if (state.items.isNotEmpty)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.limeAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: context.appTextPrimary,
                          size: 24,
                        ),
                        tooltip: 'Cart',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          );
                        },
                      ),
                      if (state.totalItemCount > 0)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: context.isDarkMode
                                  ? AppColors.limeAccent
                                  : AppColors.limeAccentDark,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${state.totalItemCount}',
                              style: const TextStyle(
                                color: AppColors.textOnLime,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(width: 8),
            ]
          : null,
    );
  }
}
