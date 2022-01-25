import '../../backend_request.dart';

class ReadAllMessagesRequest implements BackendRequest {
  final String partnerId;
  final int language;

  ReadAllMessagesRequest({
    required this.partnerId,
    this.language = 0
  });

  @override
  Map<String, dynamic> toJson() => {
    'partnerId': partnerId,
    'language': language
  };
}