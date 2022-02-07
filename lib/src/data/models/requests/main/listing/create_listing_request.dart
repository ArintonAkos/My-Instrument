import 'package:my_instrument/src/data/models/requests/multipart_request.dart';

class CreateListingRequest implements MultipartRequest {
  final String description;
  final double price;
  final int indexImageId;
  final List<String>? imagePaths;
  final int count;
  final String title;
  final int categoryId;
  final int condition;

  CreateListingRequest({
    required this.description,
    required this.price,
    required this.indexImageId,
    this.imagePaths,
    required this.count,
    required this.categoryId,
    required this.title,
    required this.condition,
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
      //'images': imagePaths.toString(),
      'count': count.toString(),
      'categoryId': categoryId.toString(),
      'title': title,
      'condition': condition.toString(),
    };
  }
}