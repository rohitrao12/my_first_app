import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/product_model.dart';
import '../../../logic/cart/cart_bloc.dart';
import '../../../logic/cart/cart_event.dart';
import '../../../logic/wishlist/wishlist_bloc.dart';
import '../../../logic/wishlist/wishlist_event.dart';
import '../../../logic/wishlist/wishlist_state.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/discount_badge.dart';
import '../../widgets/primary_button.dart';
import '../cart/cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  String _selectedSize = 'L';
  String _selectedColor = 'Black';

  final List<Color> _swatchColors = [
    AppColors.productBlack,
    AppColors.productOlive,
    AppColors.productGrey,
    AppColors.productNavy,
  ];

  @override
  Widget build(BuildContext context) {
    final images = widget.product.galleryImages.isNotEmpty
        ? widget.product.galleryImages
        : [widget.product.imageUrl];

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: context.appTextPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              final isWishlisted = state.isWishlisted(widget.product.id);
              return IconButton(
                icon: Icon(
                  isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: isWishlisted ? AppColors.error : context.appTextPrimary,
                ),
                onPressed: () {
                  context.read<WishlistBloc>().add(ToggleWishlistEvent(widget.product));
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.share_outlined, color: context.appTextPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: context.appCardElevated,
                  content: Text(
                    'Product link copied: ${widget.product.name}',
                    style: TextStyle(color: context.appTextPrimary),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel with Discount Badge
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 380,
                  child: PageView.builder(
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return CustomImage(
                        imageUrl: images[index],
                        width: double.infinity,
                        height: 380,
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                // Discount Badge on Image
                if (widget.product.discountPercent > 0)
                  Positioned(
                    top: 12,
                    left: 20,
                    child: DiscountBadge(
                      text: '${widget.product.discountPercent}% OFF',
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                  ),
                // Carousel Page Indicator Dots
                if (images.length > 1)
                  Positioned(
                    bottom: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _selectedImageIndex == index ? 16 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _selectedImageIndex == index
                                ? (context.isDarkMode ? AppColors.limeAccent : AppColors.lightTextPrimary)
                                : context.appBorder,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Product Title, Rating, Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: context.appTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Rating Stars
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            Icons.star_rounded,
                            size: 18,
                            color: context.isDarkMode ? AppColors.limeAccent : AppColors.starRating,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.product.rating}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: context.isDarkMode ? AppColors.limeAccent : AppColors.starRating,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${widget.product.reviewCount} reviews)',
                        style: TextStyle(
                          fontSize: 13,
                          color: context.appTextSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Price
                  Row(
                    children: [
                      Text(
                        '₹${widget.product.price.toInt()}',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: context.appTextPrimary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (widget.product.originalPrice > widget.product.price)
                        Text(
                          '₹${widget.product.originalPrice.toInt()}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: context.appTextMuted,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // Feature Icons Row (4-way stretch, Breathable Fabric, Quick Dry)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                decoration: BoxDecoration(
                  color: context.appCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.appBorder),
                  boxShadow: context.isDarkMode
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFeatureItem(context, Icons.all_out_rounded, '4-way Stretch'),
                    Container(height: 28, width: 1, color: context.appBorder),
                    _buildFeatureItem(context, Icons.air_rounded, 'Breathable Fabric'),
                    Container(height: 28, width: 1, color: context.appBorder),
                    _buildFeatureItem(context, Icons.flash_on_rounded, 'Quick Dry'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Size Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Size',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: context.appTextPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showSizeChartModal(context);
                        },
                        child: Text(
                          'Size Chart',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                            decoration: TextDecoration.underline,
                            decorationColor: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: widget.product.availableSizes.map((size) {
                      final isSelected = _selectedSize == size;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSize = size;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: 50,
                            height: 44,
                            decoration: BoxDecoration(
                              color: isSelected ? context.appTextPrimary : context.appCard,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected ? context.appTextPrimary : context.appBorder,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              size,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isSelected ? context.appBackground : context.appTextPrimary,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Color Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Colors',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: context.appTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: List.generate(
                      widget.product.availableColorNames.length.clamp(0, _swatchColors.length),
                      (index) {
                        final colorName = widget.product.availableColorNames[index];
                        final swatchColor = _swatchColors[index];
                        final isSelected = _selectedColor == colorName;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = colorName;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 14),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? (context.isDarkMode ? AppColors.limeAccent : AppColors.lightTextPrimary)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: swatchColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: context.appBorder, width: 1),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: context.appTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: context.appTextSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: context.appBackgroundSecondary,
          border: Border(top: BorderSide(color: context.appBorder)),
          boxShadow: context.isDarkMode
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  final isWishlisted = state.isWishlisted(widget.product.id);
                  return Container(
                    decoration: BoxDecoration(
                      color: context.appCard,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: context.appBorder),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        color: isWishlisted ? AppColors.error : context.appTextPrimary,
                      ),
                      onPressed: () {
                        context.read<WishlistBloc>().add(ToggleWishlistEvent(widget.product));
                      },
                    ),
                  );
                },
              ),
              const SizedBox(width: 14),
              Expanded(
                child: PrimaryButton(
                  text: 'ADD TO CART',
                  height: 50,
                  borderRadius: 10,
                  onPressed: () {
                    context.read<CartBloc>().add(
                          AddToCartEvent(
                            product: widget.product,
                            selectedSize: _selectedSize,
                            selectedColor: _selectedColor,
                            quantity: 1,
                          ),
                        );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: context.appCardElevated,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                          ),
                        ),
                        content: Row(
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Added to Cart: ${widget.product.name} ($_selectedSize)',
                                style: TextStyle(color: context.appTextPrimary),
                              ),
                            ),
                          ],
                        ),
                        action: SnackBarAction(
                          label: 'VIEW CART',
                          textColor: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const CartScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: context.appTextPrimary, size: 22),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: context.appTextSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showSizeChartModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.appCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Size Guide (Inches)',
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
              const SizedBox(height: 16),
              Table(
                border: TableBorder.all(color: ctx.appBorder),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: ctx.appCardElevated),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Size',
                          style: TextStyle(fontWeight: FontWeight.bold, color: ctx.appTextPrimary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Waist',
                          style: TextStyle(fontWeight: FontWeight.bold, color: ctx.appTextPrimary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Length',
                          style: TextStyle(fontWeight: FontWeight.bold, color: ctx.appTextPrimary),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('S', style: TextStyle(color: ctx.appTextPrimary))),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('28 - 30', style: TextStyle(color: ctx.appTextSecondary))),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('17"', style: TextStyle(color: ctx.appTextSecondary))),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('M', style: TextStyle(color: ctx.appTextPrimary))),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('30 - 32', style: TextStyle(color: ctx.appTextSecondary))),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('18"', style: TextStyle(color: ctx.appTextSecondary))),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('L', style: TextStyle(color: ctx.appTextPrimary))),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('32 - 34', style: TextStyle(color: ctx.appTextSecondary))),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('19"', style: TextStyle(color: ctx.appTextSecondary))),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('XL', style: TextStyle(color: ctx.appTextPrimary))),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('34 - 36', style: TextStyle(color: ctx.appTextSecondary))),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text('20"', style: TextStyle(color: ctx.appTextSecondary))),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
