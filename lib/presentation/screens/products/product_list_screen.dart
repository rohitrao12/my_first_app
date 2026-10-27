import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../logic/product/product_bloc.dart';
import '../../../logic/product/product_event.dart';
import '../../../logic/product/product_state.dart';
import 'widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  final String categoryTitle;

  const ProductListScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<String> _subcategories = [
    'All',
    'Gym Shorts',
    'Running Shorts',
    'Casual',
  ];

  String _activeSubcategory = 'All';
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FilterByCategoryEvent(widget.categoryTitle));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: context.appTextPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(color: context.appTextPrimary),
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(color: context.appTextSecondary),
                  border: InputBorder.none,
                ),
                onChanged: (val) {
                  context.read<ProductBloc>().add(SearchProductsEvent(val));
                },
              )
            : Text(
                widget.categoryTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.appTextPrimary,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close_rounded : Icons.search_rounded,
              color: context.appTextPrimary,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  context.read<ProductBloc>().add(const SearchProductsEvent(''));
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.tune_rounded, color: context.appTextPrimary),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final products = state.filteredProducts;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Chips / Pills (All, Gym Shorts, Running Shorts, Casual)
              SizedBox(
                height: 48,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  scrollDirection: Axis.horizontal,
                  itemCount: _subcategories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final sub = _subcategories[index];
                    final isSelected = _activeSubcategory == sub;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _activeSubcategory = sub;
                        });
                        context.read<ProductBloc>().add(FilterBySubcategoryEvent(sub));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
                          sub,
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

              // Product Count Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Text(
                  '${products.length} Products',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.appTextSecondary,
                  ),
                ),
              ),

              // Product Grid
              Expanded(
                child: products.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 56,
                              color: context.appTextMuted,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No products found in "$_activeSubcategory"',
                              style: TextStyle(
                                color: context.appTextSecondary,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.64,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 14,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(product: product);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.appCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sort & Filter',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ctx.appTextPrimary,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: ctx.appTextSecondary),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              Divider(color: ctx.appBorder),
              ListTile(
                title: Text('Price: Low to High', style: TextStyle(color: ctx.appTextPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, size: 14, color: ctx.appTextSecondary),
                onTap: () => Navigator.pop(ctx),
              ),
              ListTile(
                title: Text('Price: High to Low', style: TextStyle(color: ctx.appTextPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, size: 14, color: ctx.appTextSecondary),
                onTap: () => Navigator.pop(ctx),
              ),
              ListTile(
                title: Text('Top Customer Rated', style: TextStyle(color: ctx.appTextPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, size: 14, color: ctx.appTextSecondary),
                onTap: () => Navigator.pop(ctx),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
