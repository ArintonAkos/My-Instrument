import 'package:my_instrument/src/shared/utils/parsable_date_time.dart';

class MessageModel {
  MessageModel({
    required this.userId,
    required this.fullName,
    required this.creationDate,
    required this.message,
    required this.seen,
    required this.profilePicturePath
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userId: json['userId'],
      fullName: json['fullName'],
      creationDate: ParsableDateTime.fromString(json['creationDate']),
      message: json['message'],
      seen: json['seen'],
      profilePicturePath: json['profilePicturePath']
    );
  }

  late final String userId;
  late final String fullName;
  late final ParsableDateTime creationDate;
  late final String message;
  late final bool seen;
  late final String? profilePicturePath;
}