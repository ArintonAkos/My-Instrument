import 'package:my_instrument/services/models/requests/multipart_request.dart';

class ListingRequest implements MultipartRequest {
  final String listingId;
  final String description;
  final int price;
  final String? indexImagePath;
  final List<String>? imagePaths;
  final DateTime creationDate;
  final int count;
  final int categoryId;

  ListingRequest({
    required this.listingId,
    required this.description,
    required this.price,
    this.indexImagePath,
    this.imagePaths,
    required this.creationDate,
    required this.count,
    required this.categoryId
  }) {
  }

  @override
  Map<String, String> toJson() {
    return <String, String>{
      'listingId': listingId,
      'description': description,
      'price': price.toString(),
      'indexImagePath': indexImagePath ?? '',
      'categoryId': categoryId.toString(),
      'count': count.toString()
    };
  }

  @override
  List<String> getImagePaths() {
    return this.imagePaths ?? [];
  }
}