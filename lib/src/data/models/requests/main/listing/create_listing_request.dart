import 'package:my_instrument/src/data/models/requests/multipart_request.dart';
import 'package:my_instrument/src/data/models/responses/main/category/filter_entry_model.dart';

class CreateListingRequest implements MultipartRequest {
  final String description;
  final double price;
  final int indexImageId;
  final List<String>? imagePaths;
  final int count;
  final String title;
  final int categoryId;
  final int condition;
  final Map<String, FilterEntryModel> filters;

  CreateListingRequest({
    required this.description,
    required this.price,
    required this.indexImageId,
    this.imagePaths,
    required this.count,
    required this.categoryId,
    required this.title,
    required this.condition,
    required this.filters
  });

  @override
  List<String> getImagePaths() {
    return imagePaths ?? [];
  }

  @override
  Map<String, String> toJson() {
    return <String, String>{
      'description': description,
      'price': price.toString(),
      'indexImageId': indexImageId.toString(),
      'count': count.toString(),
      'categoryId': categoryId.toString(),
      'title': title,
      'condition': condition.toString(),
      'filters': filters.toString()
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'price': price,
      'indexImageId': indexImageId,
      'count': count,
      'categoryId': categoryId,
      'title': title,
      'condition': condition,
      'filters': filters
    };
  }
}