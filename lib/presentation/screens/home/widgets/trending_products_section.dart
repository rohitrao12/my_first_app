import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/product_model.dart';
import '../../products/widgets/product_card.dart';

class TrendingProductsSection extends StatelessWidget {
  final List<ProductModel> products;
  final VoidCallback onViewAll;

  const TrendingProductsSection({
    super.key,
    required this.products,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final trendingList = products.take(2).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TRENDING NOW',
                style: AppTextStyles.sectionTitle.copyWith(
                  color: context.appTextPrimary,
                ),
              ),
              GestureDetector(
                onTap: onViewAll,
                child: Row(
                  children: [
                    Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: context.appTextSecondary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: context.appTextSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: trendingList.map((product) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: product == trendingList.first ? 6 : 0,
                    left: product == trendingList.last ? 6 : 0,
                  ),
                  child: ProductCard(product: product),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
