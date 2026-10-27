import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/combo_model.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final List<CategoryModel> categories;
  final List<ComboModel> combos;
  final String selectedCategory;
  final String selectedSubcategory;
  final String searchQuery;
  final String? errorMessage;

  const ProductState({
    this.status = ProductStatus.initial,
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.categories = const [],
    this.combos = const [],
    this.selectedCategory = 'All',
    this.selectedSubcategory = 'All',
    this.searchQuery = '',
    this.errorMessage,
  });

  List<ProductModel> get trendingProducts =>
      allProducts.where((p) => p.isTrending).toList();

  ProductState copyWith({
    ProductStatus? status,
    List<ProductModel>? allProducts,
    List<ProductModel>? filteredProducts,
    List<CategoryModel>? categories,
    List<ComboModel>? combos,
    String? selectedCategory,
    String? selectedSubcategory,
    String? searchQuery,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      categories: categories ?? this.categories,
      combos: combos ?? this.combos,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSubcategory: selectedSubcategory ?? this.selectedSubcategory,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allProducts,
        filteredProducts,
        categories,
        combos,
        selectedCategory,
        selectedSubcategory,
        searchQuery,
        errorMessage,
      ];
}
