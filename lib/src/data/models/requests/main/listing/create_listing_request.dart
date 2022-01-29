import 'package:my_instrument/src/data/models/requests/multipart_request.dart';

class CreateListingRequest implements MultipartRequest {
  final String description;
  final int price;
  final String? indexImagePath;
  final List<String>? imagePaths;
  final int count;
  final String title;
  final int categoryId;

  CreateListingRequest({
    required this.description,
    required this.price,
    this.indexImagePath,
    this.imagePaths,
    required this.count,
    required this.categoryId,
    required this.title
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
      'indexImagePath': indexImagePath.toString(),
      'imagePaths': imagePaths.toString(),
      'count': count.toString(),
      'categoryId': categoryId.toString(),
      'title': title
    };
  }
}