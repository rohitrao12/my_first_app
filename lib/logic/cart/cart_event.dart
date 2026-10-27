import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';
import '../../data/models/combo_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final ProductModel product;
  final String selectedSize;
  final String selectedColor;
  final int quantity;

  const AddToCartEvent({
    required this.product,
    this.selectedSize = 'L',
    this.selectedColor = 'Black',
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [product, selectedSize, selectedColor, quantity];
}

class AddComboToCartEvent extends CartEvent {
  final ComboModel combo;

  const AddComboToCartEvent(this.combo);

  @override
  List<Object?> get props => [combo];
}

class RemoveFromCartEvent extends CartEvent {
  final String cartItemId;

  const RemoveFromCartEvent(this.cartItemId);

  @override
  List<Object?> get props => [cartItemId];
}

class UpdateCartQuantityEvent extends CartEvent {
  final String cartItemId;
  final int newQuantity;

  const UpdateCartQuantityEvent({
    required this.cartItemId,
    required this.newQuantity,
  });

  @override
  List<Object?> get props => [cartItemId, newQuantity];
}

class ApplyCouponEvent extends CartEvent {
  final String couponCode;

  const ApplyCouponEvent(this.couponCode);

  @override
  List<Object?> get props => [couponCode];
}

class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}
