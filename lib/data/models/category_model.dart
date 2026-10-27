import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final int itemCount;
  final String actionLabel;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.itemCount = 0,
    this.actionLabel = 'VIEW ALL ->',
  });

  @override
  List<Object?> get props => [id, title, imageUrl, itemCount, actionLabel];
}
