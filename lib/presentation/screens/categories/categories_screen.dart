import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/mock_shop_repository.dart';
import '../../../logic/navigation/navigation_cubit.dart';
import '../../../logic/product/product_bloc.dart';
import '../../../logic/product/product_state.dart';
import '../../widgets/custom_image.dart';
import '../combos/combo_offers_screen.dart';
import '../products/product_list_screen.dart';
import 'widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = MockShopRepository();

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: context.appTextPrimary),
          onPressed: () {
            context.read<NavigationCubit>().setTab(0);
          },
        ),
        title: Text(
          'Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.appTextPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded, color: context.appTextPrimary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProductListScreen(categoryTitle: 'Shorts'),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final categories = state.categories;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Banner: "EXPLORE OUR CATEGORIES - Gear up for a better you"
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.appBorder),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CustomImage(
                          imageUrl: repo.categoriesBannerImg,
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                          overlay: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withValues(alpha: 0.9),
                                  Colors.black.withValues(alpha: 0.6),
                                  Colors.transparent,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'EXPLORE\nOUR CATEGORIES',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                height: 1.15,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Gear up for a better you',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.limeAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 2-Column Grid of Categories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.88,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return CategoryCard(
                        category: category,
                        onTap: () {
                          if (category.title == 'Combos') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ComboOffersScreen(),
                              ),
                            );
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductListScreen(categoryTitle: category.title),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
