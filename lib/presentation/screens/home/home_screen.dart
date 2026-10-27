import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/mock_shop_repository.dart';
import '../../../logic/navigation/navigation_cubit.dart';
import '../../../logic/product/product_bloc.dart';
import '../../../logic/product/product_state.dart';
import '../../widgets/app_header.dart';
import '../combos/combo_offers_screen.dart';
import '../products/product_list_screen.dart';
import 'widgets/combo_vault_card.dart';
import 'widgets/hero_banner.dart';
import 'widgets/quick_categories_row.dart';
import 'widgets/trending_products_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = MockShopRepository();

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: const AppHeader(),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status == ProductStatus.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
              ),
            );
          }

          final categories = state.categories;
          final trending = state.trendingProducts;

          return RefreshIndicator(
            color: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
            backgroundColor: context.appCardElevated,
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 600));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Banner
                  HeroBanner(
                    imageUrl: repo.heroBannerImg,
                    onShopNow: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ProductListScreen(categoryTitle: 'Shorts'),
                        ),
                      );
                    },
                  ),

                  // Quick Categories Horizontal Grid
                  QuickCategoriesRow(
                    categories: categories,
                    onCategorySelected: (cat) {
                      if (cat.title == 'Combos') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ComboOffersScreen(),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductListScreen(categoryTitle: cat.title),
                          ),
                        );
                      }
                    },
                  ),

                  // Trending Now Section
                  TrendingProductsSection(
                    products: trending,
                    onViewAll: () {
                      context.read<NavigationCubit>().setTab(1); // Go to categories
                    },
                  ),

                  // The Combo Vault Banner
                  ComboVaultCard(
                    imageUrl: repo.combosBannerImg,
                    onExplore: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ComboOffersScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
