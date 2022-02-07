import 'package:flutter/cupertino.dart';
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

  factory IntroItem.fromCategoryModel(CategoryModel model, BuildContext context) {
    return IntroItem(
      title: model.getCategoryName(context),
      category: model.id,
      imageUrl: model.imagePath,
      imageHash: model.imageHash
    );
  }
}