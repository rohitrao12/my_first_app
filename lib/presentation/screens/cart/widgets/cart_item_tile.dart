import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/cart_item_model.dart';
import '../../../widgets/custom_image.dart';

class CartItemTile extends StatelessWidget {
  final CartItemModel item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomImage(
                  imageUrl: item.product.imageUrl,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),

              // Title and Price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
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
                          '₹${item.product.price.toInt()}',
                          style: AppTextStyles.priceCurrent,
                        ),
                        const SizedBox(width: 6),
                        if (item.product.originalPrice > item.product.price)
                          Text(
                            '₹${item.product.originalPrice.toInt()}',
                            style: AppTextStyles.priceOriginal,
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${item.selectedSize} | ${item.selectedColor}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Close / Delete Button
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 18, color: AppColors.textSecondary),
                splashRadius: 16,
                onPressed: onRemove,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Stepper + Trash icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Stepper: [-] Qty [+]
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardElevated,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 16, color: AppColors.textPrimary),
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if (item.quantity > 1) {
                          onQuantityChanged(item.quantity - 1);
                        } else {
                          onRemove();
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 16, color: AppColors.textPrimary),
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        onQuantityChanged(item.quantity + 1);
                      },
                    ),
                  ],
                ),
              ),

              // Trash bin icon
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                onPressed: onRemove,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
