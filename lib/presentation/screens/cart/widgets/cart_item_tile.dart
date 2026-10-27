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
        color: context.appCard,
        borderRadius: BorderRadius.circular(14),
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
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: context.appTextPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '₹${item.product.price.toInt()}',
                          style: AppTextStyles.priceCurrent.copyWith(
                            color: context.appTextPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (item.product.originalPrice > item.product.price)
                          Text(
                            '₹${item.product.originalPrice.toInt()}',
                            style: AppTextStyles.priceOriginal.copyWith(
                              color: context.appTextMuted,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${item.selectedSize} | ${item.selectedColor}',
                      style: TextStyle(
                        fontSize: 11,
                        color: context.appTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Close / Delete Button
              IconButton(
                icon: Icon(Icons.close_rounded, size: 18, color: context.appTextSecondary),
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
                  color: context.appCardElevated,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.appBorder),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, size: 16, color: context.appTextPrimary),
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
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: context.appTextPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, size: 16, color: context.appTextPrimary),
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
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: context.appTextSecondary,
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
