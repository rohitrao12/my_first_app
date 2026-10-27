import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/category_model.dart';
import '../../../widgets/custom_image.dart';

class QuickCategoriesRow extends StatelessWidget {
  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel> onCategorySelected;

  const QuickCategoriesRow({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final topCategories = categories.take(4).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: topCategories.map((category) {
          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: context.appCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.appBorder, width: 1.5),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CustomImage(
                      imageUrl: category.imageUrl,
                      width: 68,
                      height: 68,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: context.appTextPrimary,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
