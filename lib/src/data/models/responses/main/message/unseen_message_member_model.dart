import 'package:my_instrument/src/shared/utils/parsable_date_time.dart';

class UnseenMessageMemberModel {
  final String userId;
  final String defaultName;
  final String lastMessage;
  final ParsableDateTime? dastMessageDate;

  UnseenMessageMemberModel({
    required this.userId,
    required this.defaultName,
    required this.lastMessage,
    required this.dastMessageDate
  });

  static UnseenMessageMemberModel fromJson(Map<String, dynamic> json) {
    return UnseenMessageMemberModel(
        userId: json['userId'],
        defaultName: json['defaultName'],
        lastMessage: json['lastMessage'],
        dastMessageDate: ParsableDateTime.fromString(json['lastMessageDate'])
    );
  }
}

extension UnseenMessageMemberModelExtensions on List<String> {
  void addUnseenMessageMember({ required String newUserId }) {
    if (isNotEmpty) {
      var unseenMessengerIndex = indexWhere((element) => element == newUserId);

      if (unseenMessengerIndex == -1) {
        add(newUserId);
      }
    } else {
      add(newUserId);
    }
  }

  void removeUnseenMessageMember({ required String userId }) {
    if (isNotEmpty) {
      var messengerIndex = indexOf(userId);

      if (messengerIndex != -1) {
        removeAt(messengerIndex);
      }
    }
  }
}