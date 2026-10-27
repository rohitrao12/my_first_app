import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object?> get props => [];
}

class ToggleWishlistEvent extends WishlistEvent {
  final ProductModel product;

  const ToggleWishlistEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromWishlistEvent extends WishlistEvent {
  final String productId;

  const RemoveFromWishlistEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ClearWishlistEvent extends WishlistEvent {
  const ClearWishlistEvent();
}
