import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/combo_model.dart';
import '../../../data/repositories/mock_shop_repository.dart';
import '../../../logic/cart/cart_bloc.dart';
import '../../../logic/cart/cart_event.dart';
import '../../../logic/product/product_bloc.dart';
import '../../../logic/product/product_state.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/discount_badge.dart';
import '../../widgets/primary_button.dart';

class ComboOffersScreen extends StatefulWidget {
  const ComboOffersScreen({super.key});

  @override
  State<ComboOffersScreen> createState() => _ComboOffersScreenState();
}

class _ComboOffersScreenState extends State<ComboOffersScreen> {
  final List<String> _packFilters = ['All', '2 Pack', '3 Pack', 'Accessories'];
  String _selectedFilter = 'All';

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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Combo Offers',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.appTextPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded, color: context.appTextPrimary),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final allCombos = state.combos.isNotEmpty ? state.combos : repo.getCombos();
          final filteredCombos = _selectedFilter == 'All'
              ? allCombos
              : allCombos.where((c) => c.packType == _selectedFilter).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Banner
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.appBorder),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CustomImage(
                          imageUrl: repo.combosBannerImg,
                          width: double.infinity,
                          height: 170,
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
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'BIGGER SAVINGS\nBETTER PERFORMANCE',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                height: 1.15,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Combo Packs',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const DiscountBadge(
                              text: 'UP TO 40% OFF',
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Pack Filter Tabs
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: _packFilters.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final filter = _packFilters[index];
                      final isSelected = _selectedFilter == filter;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFilter = filter;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (context.isDarkMode ? AppColors.limeAccent : AppColors.lightTextPrimary)
                                : context.appCard,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? (context.isDarkMode ? AppColors.limeAccent : AppColors.lightTextPrimary)
                                  : context.appBorder,
                            ),
                            boxShadow: context.isDarkMode || !isSelected
                                ? null
                                : [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            filter,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected
                                  ? (context.isDarkMode ? AppColors.textOnLime : Colors.white)
                                  : context.appTextPrimary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // 2-Column Combo Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.58,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: filteredCombos.length,
                    itemBuilder: (context, index) {
                      final combo = filteredCombos[index];
                      return _buildComboCard(context, combo);
                    },
                  ),
                ),

                const SizedBox(height: 28),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildComboCard(BuildContext context, ComboModel combo) {
    return Container(
      decoration: BoxDecoration(
        color: context.appCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appBorder),
        boxShadow: context.isDarkMode
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + Badge + Heart
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: AspectRatio(
                  aspectRatio: 1.05,
                  child: CustomImage(
                    imageUrl: combo.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: DiscountBadge(
                  text: combo.packType.toUpperCase(),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border_rounded,
                    color: context.appTextPrimary,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  combo.title,
                  style: AppTextStyles.productTitle.copyWith(
                    color: context.appTextPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '₹${combo.price.toInt()}',
                      style: AppTextStyles.priceCurrent.copyWith(
                        color: context.appTextPrimary,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '₹${combo.originalPrice.toInt()}',
                      style: AppTextStyles.priceOriginal.copyWith(
                        color: context.appTextMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Save ₹${combo.savings.toInt()}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                  ),
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                  text: 'ADD TO CART',
                  height: 32,
                  width: double.infinity,
                  borderRadius: 6,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  onPressed: () {
                    context.read<CartBloc>().add(AddComboToCartEvent(combo));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: context.appCardElevated,
                        content: Text(
                          'Added ${combo.title} to cart!',
                          style: TextStyle(color: context.appTextPrimary),
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
