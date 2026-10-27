import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductEvent {
  const LoadProductsEvent();
}

class FilterByCategoryEvent extends ProductEvent {
  final String category;

  const FilterByCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class FilterBySubcategoryEvent extends ProductEvent {
  final String subcategory;

  const FilterBySubcategoryEvent(this.subcategory);

  @override
  List<Object?> get props => [subcategory];
}

class SearchProductsEvent extends ProductEvent {
  final String query;

  const SearchProductsEvent(this.query);

  @override
  List<Object?> get props => [query];
}
