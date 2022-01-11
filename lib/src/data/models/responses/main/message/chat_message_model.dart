import 'package:my_instrument/shared/utils/parsable_date_time.dart';

class ChatMessageModel {
  ChatMessageModel({
    required this.userId,
    required this.fullName,
    required this.creationDate,
    required this.message,
    required this.profilePicturePath,
    required this.dateSeen
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      userId: json['userId'],
      creationDate: ParsableDateTime.fromString(json['creationDate']),
      message: json['message'],
      dateSeen: ParsableDateTime.fromString(json['dateSeen']),
      profilePicturePath: json['profilePicturePath'],
      fullName: json['fullName'],
    );
  }

  late final String userId;
  late final String fullName;
  late final ParsableDateTime? creationDate;
  late final String message;
  late final String? profilePicturePath;
  late final ParsableDateTime? dateSeen;

  get seen {
    return (dateSeen == null);
  }
}