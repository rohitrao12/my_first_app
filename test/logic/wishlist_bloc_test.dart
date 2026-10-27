import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/data/repositories/mock_shop_repository.dart';
import 'package:my_first_app/logic/wishlist/wishlist_bloc.dart';
import 'package:my_first_app/logic/wishlist/wishlist_event.dart';

void main() {
  late MockShopRepository repository;
  late WishlistBloc wishlistBloc;

  setUp(() {
    repository = MockShopRepository();
    wishlistBloc = WishlistBloc(repository: repository);
  });

  tearDown(() {
    wishlistBloc.close();
  });

  group('WishlistBloc Tests', () {
    test('Initial wishlist contains pre-wishlisted items', () {
      expect(wishlistBloc.state.items.isNotEmpty, true);
      expect(wishlistBloc.state.isWishlisted('p1'), true);
    });

    test('ToggleWishlistEvent removes existing item', () {
      final product = repository.getProducts().firstWhere((p) => p.id == 'p1');
      wishlistBloc.add(ToggleWishlistEvent(product));

      expectLater(
        wishlistBloc.stream,
        emits(predicate<dynamic>((state) {
          return !state.isWishlisted('p1');
        })),
      );
    });

    test('ClearWishlistEvent clears all items', () {
      wishlistBloc.add(const ClearWishlistEvent());

      expectLater(
        wishlistBloc.stream,
        emits(predicate<dynamic>((state) {
          return state.items.isEmpty;
        })),
      );
    });
  });
}
