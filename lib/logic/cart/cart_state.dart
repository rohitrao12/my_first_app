import 'package:equatable/equatable.dart';
import '../../data/models/cart_item_model.dart';

class CartState extends Equatable {
  final List<CartItemModel> items;
  final double discountAmount;
  final String? appliedCoupon;
  final String? promoMessage;

  const CartState({
    this.items = const [],
    this.discountAmount = 300.0,
    this.appliedCoupon,
    this.promoMessage,
  });

  int get totalItemCount =>
      items.fold(0, (total, current) => total + current.quantity);

  double get subtotal =>
      items.fold(0.0, (total, current) => total + current.totalPrice);

  double get originalSubtotal =>
      items.fold(0.0, (total, current) => total + current.originalTotalPrice);

  double get shippingFee => items.isEmpty ? 0.0 : 0.0; // Free shipping

  double get finalTotal {
    if (items.isEmpty) return 0.0;
    final total = subtotal - discountAmount;
    return total > 0 ? total : 0.0;
  }

  CartState copyWith({
    List<CartItemModel>? items,
    double? discountAmount,
    String? appliedCoupon,
    String? promoMessage,
  }) {
    return CartState(
      items: items ?? this.items,
      discountAmount: discountAmount ?? this.discountAmount,
      appliedCoupon: appliedCoupon ?? this.appliedCoupon,
      promoMessage: promoMessage,
    );
  }

  @override
  List<Object?> get props => [items, discountAmount, appliedCoupon, promoMessage];
}
