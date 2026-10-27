import 'package:equatable/equatable.dart';

class ComboModel extends Equatable {
  final String id;
  final String title;
  final String packType; // "2 Pack", "3 Pack", "Accessories"
  final double price;
  final double originalPrice;
  final double savings;
  final String imageUrl;
  final List<String> includedItems;

  const ComboModel({
    required this.id,
    required this.title,
    required this.packType,
    required this.price,
    required this.originalPrice,
    required this.savings,
    required this.imageUrl,
    required this.includedItems,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        packType,
        price,
        originalPrice,
        savings,
        imageUrl,
        includedItems,
      ];
}
