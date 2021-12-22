import 'package:my_instrument/services/models/responses/main/category/category_model.dart';

class ListingModel {
  final String listingId;
  final String description;
  final int price;
  final String? indexImagePath;
  final DateTime? creationDate;
  final String userId;
  final CategoryModel category;

  ListingModel({
    required this.listingId,
    required this.description,
    required this.price,
    this.indexImagePath,
    this.creationDate,
    required this.userId,
    required this.category
  });

  factory ListingModel.fromJson(Map<String, dynamic> json) {
   return ListingModel(
     listingId: json['listingId'],
     description: json['description'],
     price: json['price'],
     indexImagePath: json['indexImagePath'],
     creationDate: json['creationDate'],
     userId: json['userId'],
     category: CategoryModel(json: json['category'])
   );
  }
}