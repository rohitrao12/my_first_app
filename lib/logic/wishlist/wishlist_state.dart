import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';

class WishlistState extends Equatable {
  final List<ProductModel> items;

  const WishlistState({this.items = const []});

  bool isWishlisted(String productId) {
    return items.any((item) => item.id == productId);
  }

  WishlistState copyWith({List<ProductModel>? items}) {
    return WishlistState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}
