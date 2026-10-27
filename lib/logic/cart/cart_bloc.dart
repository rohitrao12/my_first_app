import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/mock_shop_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required MockShopRepository repository})
      : super(_buildInitialState(repository)) {
    on<AddToCartEvent>(_onAddToCart);
    on<AddComboToCartEvent>(_onAddComboToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartQuantityEvent>(_onUpdateQuantity);
    on<ApplyCouponEvent>(_onApplyCoupon);
    on<ClearCartEvent>(_onClearCart);
  }

  static CartState _buildInitialState(MockShopRepository repo) {
    final products = repo.getProducts();
    if (products.length >= 2) {
      final initialCartItems = [
        CartItemModel(
          id: 'cart_1',
          product: products[0], // 4-Way Stretch Gym Shorts (499)
          selectedSize: 'L',
          selectedColor: 'Black',
          quantity: 1,
        ),
        CartItemModel(
          id: 'cart_2',
          product: products[1].copyWith(price: 589), // Cargo Trackpants (589)
          selectedSize: 'L',
          selectedColor: 'Black',
          quantity: 1,
        ),
      ];
      return CartState(
        items: initialCartItems,
        discountAmount: 300.0,
        appliedCoupon: '11FIT300',
        promoMessage: 'Coupon 11FIT300 applied (-₹300)',
      );
    }
    return const CartState();
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final existingIndex = state.items.indexWhere((item) =>
        item.product.id == event.product.id &&
        item.selectedSize == event.selectedSize &&
        item.selectedColor == event.selectedColor);

    if (existingIndex >= 0) {
      final existingItem = state.items[existingIndex];
      final updatedList = List<CartItemModel>.from(state.items);
      updatedList[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + event.quantity,
      );
      emit(state.copyWith(items: updatedList));
    } else {
      final newItem = CartItemModel(
        id: 'cart_${DateTime.now().millisecondsSinceEpoch}',
        product: event.product,
        selectedSize: event.selectedSize,
        selectedColor: event.selectedColor,
        quantity: event.quantity,
      );
      emit(state.copyWith(items: [...state.items, newItem]));
    }
  }

  void _onAddComboToCart(AddComboToCartEvent event, Emitter<CartState> emit) {
    final comboProduct = ProductModel(
      id: 'combo_prod_${event.combo.id}',
      name: event.combo.title,
      category: 'Combos',
      subcategory: event.combo.packType,
      price: event.combo.price,
      originalPrice: event.combo.originalPrice,
      discountPercent: ((event.combo.savings / event.combo.originalPrice) * 100).round(),
      rating: 4.8,
      reviewCount: 340,
      imageUrl: event.combo.imageUrl,
      description: 'Combo Pack featuring: ${event.combo.includedItems.join(", ")}',
      features: const ['Special Combo Pricing', 'Color Matched', 'Limited Edition'],
      availableSizes: const ['S', 'M', 'L', 'XL'],
      availableColorNames: const ['Set As Shown'],
    );

    add(AddToCartEvent(
      product: comboProduct,
      selectedSize: 'L',
      selectedColor: 'Default',
      quantity: 1,
    ));
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final updatedList =
        state.items.where((item) => item.id != event.cartItemId).toList();
    emit(state.copyWith(items: updatedList));
  }

  void _onUpdateQuantity(UpdateCartQuantityEvent event, Emitter<CartState> emit) {
    if (event.newQuantity <= 0) {
      add(RemoveFromCartEvent(event.cartItemId));
      return;
    }
    final index = state.items.indexWhere((item) => item.id == event.cartItemId);
    if (index >= 0) {
      final updatedList = List<CartItemModel>.from(state.items);
      updatedList[index] =
          updatedList[index].copyWith(quantity: event.newQuantity);
      emit(state.copyWith(items: updatedList));
    }
  }

  void _onApplyCoupon(ApplyCouponEvent event, Emitter<CartState> emit) {
    final code = event.couponCode.trim().toUpperCase();
    if (code == '11FIT40' || code == 'FIT40') {
      emit(state.copyWith(
        discountAmount: 400.0,
        appliedCoupon: code,
        promoMessage: '₹400 discount applied!',
      ));
    } else if (code == '11FIT300') {
      emit(state.copyWith(
        discountAmount: 300.0,
        appliedCoupon: code,
        promoMessage: '₹300 discount applied!',
      ));
    } else if (code == 'WELCOME10') {
      emit(state.copyWith(
        discountAmount: 150.0,
        appliedCoupon: code,
        promoMessage: '₹150 welcome discount applied!',
      ));
    } else {
      emit(state.copyWith(
        promoMessage: 'Invalid promo code. Try 11FIT40 or WELCOME10',
      ));
    }
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    emit(const CartState(items: [], discountAmount: 0.0, appliedCoupon: null));
  }
}
