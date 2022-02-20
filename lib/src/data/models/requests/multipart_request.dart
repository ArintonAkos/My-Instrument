abstract class MultipartRequest {
  Map<String, String> toJson();
  List<String> getImagePaths();
  Map<String, dynamic> toMap();
}