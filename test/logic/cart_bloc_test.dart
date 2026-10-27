import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/data/repositories/mock_shop_repository.dart';
import 'package:my_first_app/logic/cart/cart_bloc.dart';
import 'package:my_first_app/logic/cart/cart_event.dart';

void main() {
  late MockShopRepository repository;
  late CartBloc cartBloc;

  setUp(() {
    repository = MockShopRepository();
    cartBloc = CartBloc(repository: repository);
  });

  tearDown(() {
    cartBloc.close();
  });

  group('CartBloc Tests', () {
    test('Initial state contains mock items with discount matching mockup', () {
      expect(cartBloc.state.items.length, 2);
      expect(cartBloc.state.totalItemCount, 2);
      expect(cartBloc.state.discountAmount, 300.0);
      expect(cartBloc.state.finalTotal, 788.0); // 499 + 589 - 300 = 788
    });

    test('AddToCartEvent adds product or increases quantity', () {
      final product = repository.getProducts().first;
      cartBloc.add(AddToCartEvent(
        product: product,
        selectedSize: 'XL',
        selectedColor: 'Black',
        quantity: 1,
      ));

      expectLater(
        cartBloc.stream,
        emits(predicate<dynamic>((state) {
          return state.items.length == 3 && state.totalItemCount == 3;
        })),
      );
    });

    test('UpdateCartQuantityEvent updates quantity correctly', () {
      final firstItemId = cartBloc.state.items.first.id;
      cartBloc.add(UpdateCartQuantityEvent(
        cartItemId: firstItemId,
        newQuantity: 3,
      ));

      expectLater(
        cartBloc.stream,
        emits(predicate<dynamic>((state) {
          return state.totalItemCount == 4; // 3 + 1 = 4
        })),
      );
    });

    test('ApplyCouponEvent applies FIT40 discount', () {
      cartBloc.add(const ApplyCouponEvent('11FIT40'));

      expectLater(
        cartBloc.stream,
        emits(predicate<dynamic>((state) {
          return state.discountAmount == 400.0;
        })),
      );
    });

    test('ClearCartEvent empties cart', () {
      cartBloc.add(const ClearCartEvent());

      expectLater(
        cartBloc.stream,
        emits(predicate<dynamic>((state) {
          return state.items.isEmpty && state.totalItemCount == 0;
        })),
      );
    });
  });
}
