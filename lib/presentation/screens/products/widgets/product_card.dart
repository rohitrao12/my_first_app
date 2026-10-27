import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/product_model.dart';
import '../../../../logic/wishlist/wishlist_bloc.dart';
import '../../../../logic/wishlist/wishlist_event.dart';
import '../../../../logic/wishlist/wishlist_state.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/discount_badge.dart';
import '../product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: product),
              ),
            );
          },
      child: Container(
        decoration: BoxDecoration(
          color: context.appCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.appBorder, width: 1),
          boxShadow: context.isDarkMode
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + Badges Stack
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: CustomImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Discount Badge
                if (product.discountPercent > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: DiscountBadge(
                      text: '${product.discountPercent}% OFF',
                    ),
                  ),
                // Wishlist Heart Icon
                Positioned(
                  top: 4,
                  right: 4,
                  child: BlocBuilder<WishlistBloc, WishlistState>(
                    builder: (context, state) {
                      final isWishlisted = state.isWishlisted(product.id);
                      return IconButton(
                        icon: Icon(
                          isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: isWishlisted ? AppColors.error : context.appTextPrimary,
                          size: 20,
                        ),
                        splashRadius: 18,
                        onPressed: () {
                          context.read<WishlistBloc>().add(ToggleWishlistEvent(product));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.productTitle.copyWith(
                      color: context.appTextPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '₹${product.price.toInt()}',
                        style: AppTextStyles.priceCurrent.copyWith(
                          color: context.appTextPrimary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (product.originalPrice > product.price)
                        Text(
                          '₹${product.originalPrice.toInt()}',
                          style: AppTextStyles.priceOriginal.copyWith(
                            color: context.appTextMuted,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.starRating,
                        size: 15,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${product.rating}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: context.appTextPrimary,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '(${_formatReviewCount(product.reviewCount)})',
                        style: TextStyle(
                          fontSize: 11,
                          color: context.appTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatReviewCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
