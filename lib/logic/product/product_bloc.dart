import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/mock_shop_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final MockShopRepository repository;

  ProductBloc({required this.repository}) : super(const ProductState()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<FilterByCategoryEvent>(_onFilterByCategory);
    on<FilterBySubcategoryEvent>(_onFilterBySubcategory);
    on<SearchProductsEvent>(_onSearchProducts);

    add(const LoadProductsEvent());
  }

  void _onLoadProducts(LoadProductsEvent event, Emitter<ProductState> emit) {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final products = repository.getProducts();
      final categories = repository.getCategories();
      final combos = repository.getCombos();

      emit(state.copyWith(
        status: ProductStatus.loaded,
        allProducts: products,
        filteredProducts: products,
        categories: categories,
        combos: combos,
        selectedCategory: 'All',
        selectedSubcategory: 'All',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: 'Failed to load products: ${e.toString()}',
      ));
    }
  }

  void _onFilterByCategory(
      FilterByCategoryEvent event, Emitter<ProductState> emit) {
    final cat = event.category;
    List<ProductModel> filtered;

    if (cat == 'All') {
      filtered = state.allProducts;
    } else {
      filtered = state.allProducts
          .where((p) => p.category.toLowerCase() == cat.toLowerCase())
          .toList();
    }

    emit(state.copyWith(
      selectedCategory: cat,
      selectedSubcategory: 'All',
      filteredProducts: filtered,
    ));
  }

  void _onFilterBySubcategory(
      FilterBySubcategoryEvent event, Emitter<ProductState> emit) {
    final sub = event.subcategory;
    List<ProductModel> baseList;

    if (state.selectedCategory == 'All') {
      baseList = state.allProducts;
    } else {
      baseList = state.allProducts
          .where((p) =>
              p.category.toLowerCase() == state.selectedCategory.toLowerCase())
          .toList();
    }

    List<ProductModel> filtered;
    if (sub == 'All') {
      filtered = baseList;
    } else {
      filtered = baseList
          .where((p) => p.subcategory.toLowerCase() == sub.toLowerCase())
          .toList();
    }

    emit(state.copyWith(
      selectedSubcategory: sub,
      filteredProducts: filtered,
    ));
  }

  void _onSearchProducts(
      SearchProductsEvent event, Emitter<ProductState> emit) {
    final query = event.query.toLowerCase().trim();
    List<ProductModel> filtered;

    if (query.isEmpty) {
      filtered = state.allProducts;
    } else {
      filtered = state.allProducts
          .where((p) =>
              p.name.toLowerCase().contains(query) ||
              p.category.toLowerCase().contains(query) ||
              p.subcategory.toLowerCase().contains(query) ||
              p.description.toLowerCase().contains(query))
          .toList();
    }

    emit(state.copyWith(
      searchQuery: event.query,
      filteredProducts: filtered,
    ));
  }
}
