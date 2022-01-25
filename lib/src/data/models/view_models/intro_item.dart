import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';

class IntroItem{
  IntroItem({
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.imageHash
  });

  final String title;
  final int category;
  final String? imageUrl;
  final String? imageHash;

  factory IntroItem.fromCategoryModel(CategoryModel model) {
    return IntroItem(
      title: model.nameEn,
      category: model.id,
      imageUrl: model.imagePath,
      imageHash: model.imageHash
    );
  }
}