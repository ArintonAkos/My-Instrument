import 'package:my_instrument/services/models/responses/main/category/category_model.dart';
import 'package:my_instrument/shared/utils/parsable_date_time.dart';

class ListingModel {
  final String listingId;
  final String description;
  final int price;
  late final String indexImagePath;
  late final String indexImageHash;
  final ParsableDateTime creationDate;
  final String userId;
  final CategoryModel category;

  ListingModel({
    required this.listingId,
    required this.description,
    required this.price,
    String? indexImagePath,
    String? indexImageHash,
    required this.creationDate,
    required this.userId,
    required this.category
  }) {
    this.indexImagePath = indexImagePath ?? '';
    this.indexImageHash = indexImageHash ?? '';
  }

  factory ListingModel.fromJson(Map<String, dynamic> json) {
   return ListingModel(
     listingId: json['listingId'],
     description: json['description'],
     price: json['price'],
     indexImagePath: json['indexImagePath'],
     indexImageHash: json['indexImageHash'],
     creationDate: ParsableDateTime.fromString(json['creationDate']),
     userId: json['userId'],
     category: CategoryModel(json: json['category'])
   );
  }
}