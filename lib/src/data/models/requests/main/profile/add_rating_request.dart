import 'package:my_instrument/src/data/models/requests/backend_request.dart';

class AddRatingRequest implements BackendRequest {

  final String forUserId;
  final int value;
  final String title;
  final String description;

  AddRatingRequest({
    required this.forUserId,
    required this.value,
    required this.title,
    required this.description
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'forUserId': forUserId,
      'value': value,
      'title': title,
      'description': description
    };
  }
}