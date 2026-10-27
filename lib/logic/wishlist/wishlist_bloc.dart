import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/mock_shop_repository.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc({required MockShopRepository repository})
      : super(WishlistState(
          items: repository.getProducts().where((p) => p.isWishlisted).toList(),
        )) {
    on<ToggleWishlistEvent>(_onToggleWishlist);
    on<RemoveFromWishlistEvent>(_onRemoveFromWishlist);
    on<ClearWishlistEvent>(_onClearWishlist);
  }

  void _onToggleWishlist(ToggleWishlistEvent event, Emitter<WishlistState> emit) {
    final isPresent = state.items.any((item) => item.id == event.product.id);
    if (isPresent) {
      final updated = state.items.where((item) => item.id != event.product.id).toList();
      emit(state.copyWith(items: updated));
    } else {
      final updated = [...state.items, event.product];
      emit(state.copyWith(items: updated));
    }
  }

  void _onRemoveFromWishlist(RemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
    final updated = state.items.where((item) => item.id != event.productId).toList();
    emit(state.copyWith(items: updated));
  }

  void _onClearWishlist(ClearWishlistEvent event, Emitter<WishlistState> emit) {
    emit(const WishlistState(items: []));
  }
}
