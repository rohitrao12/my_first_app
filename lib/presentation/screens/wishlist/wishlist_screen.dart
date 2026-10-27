import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../logic/cart/cart_bloc.dart';
import '../../../logic/cart/cart_event.dart';
import '../../../logic/navigation/navigation_cubit.dart';
import '../../../logic/wishlist/wishlist_bloc.dart';
import '../../../logic/wishlist/wishlist_event.dart';
import '../../../logic/wishlist/wishlist_state.dart';
import '../../widgets/primary_button.dart';
import '../products/product_detail_screen.dart';
import 'widgets/wishlist_item_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appBackground,
        elevation: 0,
        title: Text(
          'Wishlist',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: context.appTextPrimary,
          ),
        ),
        actions: [
          BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              if (state.items.isEmpty) return const SizedBox.shrink();
              return TextButton(
                onPressed: () {
                  context.read<WishlistBloc>().add(const ClearWishlistEvent());
                },
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    color: context.appTextSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          final items = state.items;

          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 64,
                      color: context.appTextMuted,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your Wishlist is Empty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.appTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Explore our athletic collection and save your favorite gear for later.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: context.appTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'START EXPLORING',
                      showArrow: true,
                      height: 44,
                      onPressed: () {
                        context.read<NavigationCubit>().setTab(0);
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              return WishlistItemCard(
                product: product,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                onAddToCart: () {
                  context.read<CartBloc>().add(
                        AddToCartEvent(
                          product: product,
                          selectedSize: 'L',
                          selectedColor: product.availableColorNames.first,
                        ),
                      );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: context.appCardElevated,
                      content: Text(
                        'Added ${product.name} to cart!',
                        style: TextStyle(color: context.appTextPrimary),
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                onRemove: () {
                  context.read<WishlistBloc>().add(RemoveFromWishlistEvent(product.id));
                },
              );
            },
          );
        },
      ),
    );
  }
}
