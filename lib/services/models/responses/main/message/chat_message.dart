import 'package:my_instrument/shared/utils/parsable_date_time.dart';

class ChatMessage {
  final String userName;
  final String message;
  final String userId;
  final String email;
  final ParsableDateTime creationDate;
  final String? creationDateString;

  ChatMessage({
    required this.userName,
    required this.message,
    required this.userId,
    required this.email,
    required this.creationDate,
    required this.creationDateString
  });

  static ChatMessage fromJson(Map<String, dynamic> json) {
    var creationDate = ParsableDateTime.fromString(json['creationDate']);
    return ChatMessage(
      userName: json['userName'],
      message: json['message'],
      userId: json['userId'],
      email: json['email'],
      creationDate: creationDate,
      creationDateString: creationDate.toLocaleString()
    );
  }
}