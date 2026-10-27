import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../logic/cart/cart_bloc.dart';
import '../../../logic/cart/cart_event.dart';
import '../../../logic/cart/cart_state.dart';
import '../../widgets/primary_button.dart';
import 'widgets/cart_item_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
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
        title: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Cart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.appTextPrimary,
                  ),
                ),
                Text(
                  '${state.totalItemCount} Items',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.appTextSecondary,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: context.appTextMuted,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your Cart is Empty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.appTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Looks like you haven\'t added any items to your cart yet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: context.appTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'SHOP NOW',
                      showArrow: true,
                      height: 44,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart Items List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return CartItemTile(
                      item: item,
                      onQuantityChanged: (newQty) {
                        context.read<CartBloc>().add(
                              UpdateCartQuantityEvent(
                                cartItemId: item.id,
                                newQuantity: newQty,
                              ),
                            );
                      },
                      onRemove: () {
                        context.read<CartBloc>().add(RemoveFromCartEvent(item.id));
                      },
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Order Summary Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.appCard,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: context.appBorder),
                    boxShadow: context.isDarkMode
                        ? null
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price (${state.totalItemCount} items)',
                            style: TextStyle(
                              fontSize: 14,
                              color: context.appTextSecondary,
                            ),
                          ),
                          Text(
                            '₹${state.subtotal.toInt()}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.appTextPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount',
                            style: TextStyle(
                              fontSize: 14,
                              color: context.appTextSecondary,
                            ),
                          ),
                          Text(
                            '-₹${state.discountAmount.toInt()}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping',
                            style: TextStyle(
                              fontSize: 14,
                              color: context.appTextSecondary,
                            ),
                          ),
                          Text(
                            'Free',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 24, color: context.appBorder),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: context.appTextPrimary,
                            ),
                          ),
                          Text(
                            '₹${state.finalTotal.toInt()}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: context.appTextPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Proceed to Checkout Button
                PrimaryButton(
                  text: 'Proceed to Checkout',
                  showArrow: true,
                  height: 52,
                  width: double.infinity,
                  borderRadius: 10,
                  onPressed: () {
                    _showCheckoutConfirmation(context, state);
                  },
                ),

                const SizedBox(height: 16),

                // Coupon Code Box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: context.appCard,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: context.appBorder),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_offer_outlined, color: context.appTextSecondary, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _couponController,
                          style: TextStyle(color: context.appTextPrimary, fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Have a coupon code?',
                            hintStyle: TextStyle(color: context.appTextMuted, fontSize: 13),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_couponController.text.isNotEmpty) {
                            context.read<CartBloc>().add(ApplyCouponEvent(_couponController.text));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: context.appCardElevated,
                                content: Text(
                                  'Coupon ${_couponController.text.toUpperCase()} verified!',
                                  style: TextStyle(color: context.appTextPrimary),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Apply',
                          style: TextStyle(
                            color: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showCheckoutConfirmation(BuildContext context, CartState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.appCard,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: ctx.appBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Icon(
                Icons.check_circle_rounded,
                color: ctx.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Ready to Place Order',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ctx.appTextPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Total Payable: ₹${state.finalTotal.toInt()}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ctx.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Deliver to: Rohit Rao\nFlat 402, Elite Heights, Mumbai, 400001',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: ctx.appTextSecondary,
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'CONFIRM & PAY',
                width: double.infinity,
                height: 50,
                borderRadius: 10,
                onPressed: () {
                  Navigator.pop(ctx);
                  context.read<CartBloc>().add(const ClearCartEvent());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: context.appCardElevated,
                      content: Row(
                        children: [
                          Icon(
                            Icons.done_all_rounded,
                            color: context.isDarkMode ? AppColors.limeAccent : AppColors.limeAccentDark,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Order #11FIT-${8923} Placed Successfully!',
                            style: TextStyle(color: context.appTextPrimary),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
