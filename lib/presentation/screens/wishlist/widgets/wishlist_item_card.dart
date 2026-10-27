import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/product_model.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';

class WishlistItemCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onAddToCart;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const WishlistItemCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Product Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomImage(
                imageUrl: product.imageUrl,
                width: 76,
                height: 76,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '₹${product.price.toInt()}',
                        style: AppTextStyles.priceCurrent,
                      ),
                      const SizedBox(width: 6),
                      if (product.originalPrice > product.price)
                        Text(
                          '₹${product.originalPrice.toInt()}',
                          style: AppTextStyles.priceOriginal,
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'L | ${product.availableColorNames.first}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // ADD TO CART Lime Button
                  PrimaryButton(
                    text: 'ADD TO CART',
                    height: 32,
                    borderRadius: 6,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    onPressed: onAddToCart,
                  ),
                ],
              ),
            ),

            // Red Heart Wishlist Action
            IconButton(
              icon: const Icon(
                Icons.favorite_rounded,
                color: AppColors.error,
                size: 22,
              ),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
