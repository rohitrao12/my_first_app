import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/data/models/product_model.dart';
import 'package:my_first_app/data/repositories/mock_shop_repository.dart';
import 'package:my_first_app/logic/product/product_bloc.dart';
import 'package:my_first_app/logic/product/product_event.dart';
import 'package:my_first_app/logic/product/product_state.dart';

void main() {
  late MockShopRepository repository;
  late ProductBloc productBloc;

  setUp(() {
    repository = MockShopRepository();
    productBloc = ProductBloc(repository: repository);
  });

  tearDown(() {
    productBloc.close();
  });

  group('ProductBloc Tests', () {
    test('Initial load populates products and categories', () async {
      await Future.delayed(const Duration(milliseconds: 50));
      expect(productBloc.state.allProducts.isNotEmpty, true);
      expect(productBloc.state.categories.isNotEmpty, true);
      expect(productBloc.state.combos.isNotEmpty, true);
    });

    test('FilterByCategoryEvent filters products correctly', () {
      productBloc.add(const FilterByCategoryEvent('Shorts'));

      expectLater(
        productBloc.stream,
        emits(predicate<ProductState>((state) {
          return state.selectedCategory == 'Shorts' &&
              state.filteredProducts.every((ProductModel p) => p.category == 'Shorts');
        })),
      );
    });

    test('SearchProductsEvent filters by query', () {
      productBloc.add(const SearchProductsEvent('Cargo'));

      expectLater(
        productBloc.stream,
        emits(predicate<ProductState>((state) {
          return state.filteredProducts.any((ProductModel p) => p.name.contains('Cargo'));
        })),
      );
    });
  });
}
