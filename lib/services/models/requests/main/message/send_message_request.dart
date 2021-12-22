import '../../backend_request.dart';

class SendMessageRequest implements BackendRequest {
  final String toUserId;
  final String message;
  final int language;

  SendMessageRequest({
    required this.toUserId,
    required this.message,
    this.language = 0
  });

  @override
  Map<String, dynamic> toJson() => {
    'toUserId': toUserId,
    'message': message,
    'language': language.toString(),
  };
}