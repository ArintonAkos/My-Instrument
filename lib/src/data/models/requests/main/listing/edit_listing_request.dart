import '../../multipart_request.dart';

class EditListingRequest implements MultipartRequest {
  final String listingId;
  final String description;
  final int price;
  final String? indexImagePath;
  final List<String>? imagePaths;
  final DateTime creationDate;
  final int count;
  final int categoryId;

  EditListingRequest({
    required this.listingId,
    required this.description,
    required this.price,
    this.indexImagePath,
    this.imagePaths,
    required this.creationDate,
    required this.count,
    required this.categoryId
  });

  @override
  Map<String, String> toJson() {
    return <String, String>{
      'listingId': listingId,
      'description': description,
      'price': price.toString(),
      'indexImagePath': indexImagePath.toString(),
      'imagePaths': imagePaths.toString(),
      'categoryId': categoryId.toString(),
      'creationDate': creationDate.toIso8601String(),
      'count': count.toString()
    };
  }

  @override
  List<String> getImagePaths() {
    return imagePaths ?? [];
  }

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}