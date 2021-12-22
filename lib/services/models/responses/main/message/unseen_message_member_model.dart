import 'package:collection/src/iterable_extensions.dart';
import 'package:my_instrument/services/models/responses/main/message/chat_message.dart';
import 'package:my_instrument/shared/utils/parsable_date_time.dart';

class UnseenMessageMemberModel {
  final String UserId;
  final String DefaultName;
  final String LastMessage;
  final ParsableDateTime? LastMessageDate;

  UnseenMessageMemberModel({
    required this.UserId,
    required this.DefaultName,
    required this.LastMessage,
    required this.LastMessageDate
  });

  static UnseenMessageMemberModel fromJson(Map<String, dynamic> json) {
    return UnseenMessageMemberModel(
        UserId: json['userId'],
        DefaultName: json['defaultName'],
        LastMessage: json['lastMessage'],
        LastMessageDate: ParsableDateTime.fromString(json['lastMessageDate'])
    );
  }
}

extension UnseenMessageMemberModelExtensions on List<String> {
  void addUnseenMessageMember({ required String newUserId }) {
    if (isNotEmpty) {
      var unseenMessengerId = firstWhereOrNull((element) => element == newUserId);

      if (unseenMessengerId == null) {
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