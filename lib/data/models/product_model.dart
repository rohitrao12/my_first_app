import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String category;
  final String subcategory;
  final double price;
  final double originalPrice;
  final int discountPercent;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final List<String> galleryImages;
  final String description;
  final List<String> features;
  final List<String> availableSizes;
  final List<String> availableColorNames;
  final bool isTrending;
  final bool isWishlisted;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.price,
    required this.originalPrice,
    required this.discountPercent,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    this.galleryImages = const [],
    required this.description,
    this.features = const [
      '4-Way Stretch',
      'Breathable Fabric',
      'Quick Dry',
    ],
    this.availableSizes = const ['S', 'M', 'L', 'XL', 'XXL'],
    this.availableColorNames = const ['Black', 'Olive Green', 'Light Grey', 'Navy Blue'],
    this.isTrending = false,
    this.isWishlisted = false,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? category,
    String? subcategory,
    double? price,
    double? originalPrice,
    int? discountPercent,
    double? rating,
    int? reviewCount,
    String? imageUrl,
    List<String>? galleryImages,
    String? description,
    List<String>? features,
    List<String>? availableSizes,
    List<String>? availableColorNames,
    bool? isTrending,
    bool? isWishlisted,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPercent: discountPercent ?? this.discountPercent,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      imageUrl: imageUrl ?? this.imageUrl,
      galleryImages: galleryImages ?? this.galleryImages,
      description: description ?? this.description,
      features: features ?? this.features,
      availableSizes: availableSizes ?? this.availableSizes,
      availableColorNames: availableColorNames ?? this.availableColorNames,
      isTrending: isTrending ?? this.isTrending,
      isWishlisted: isWishlisted ?? this.isWishlisted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        subcategory,
        price,
        originalPrice,
        discountPercent,
        rating,
        reviewCount,
        imageUrl,
        galleryImages,
        description,
        features,
        availableSizes,
        availableColorNames,
        isTrending,
        isWishlisted,
      ];
}
