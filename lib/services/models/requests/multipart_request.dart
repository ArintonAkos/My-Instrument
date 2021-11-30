import 'package:my_instrument/services/models/requests/backend_request.dart';

abstract class MultipartRequest {
  Map<String, String> toJson();
  List<String> getImagePaths();
}