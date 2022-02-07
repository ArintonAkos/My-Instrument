import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/data/models/view_models/shared_preferences_data.dart';
import 'package:my_instrument/src/shared/utils/parse_methods.dart';

class NewListingLocalData extends Equatable implements SharedPreferencesData {
  final String title;
  final double price;
  final String description;
  final int condition;
  final List<String> images;
  final CategoryModel category;
  final int count;

  NewListingLocalData({
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.condition,
    required this.category,
    required this.count
  });

  factory NewListingLocalData.fromJson(Map<String, dynamic> parsedJson) {
    return NewListingLocalData(
      title: parsedJson['title'] ?? "",
      price: parsedJson['price'] ?? 0,
      description: parsedJson['description'] ?? "",
      images: ParseMethods.parseStringList(parsedJson['images']),
      condition: parsedJson['condition'] ?? 0,
      category: CategoryModel.parseCategoryModel(parsedJson['category']) ?? CategoryModel.base(),
      count: parsedJson['count'] ?? 0,
    );
  }

  factory NewListingLocalData.defaultState() {
    return NewListingLocalData(
      title: "",
      price: 0,
      description: "",
      images: [],
      condition: 0,
      category: CategoryModel.base(),
      count: 0
    );
  }

  @override
  Map<String, dynamic> toJson() {
   return {
     "title": title,
     "price": price,
     "description": description,
     "images": images,
     "condition": condition,
     "category": category,
     "count": count

   };
  }

  @override
  List<Object> get props => [
    title,
    price,
    description,
    images,
    condition,
    category,
    count
  ];
}

