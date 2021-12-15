class MessageModel {
  Map<String, dynamic>? json;

  MessageModel({ required this.json }) {
    userId = json?['userId'];
    fullName = json?['fullName'];
    lastMessageSentAt = json?['creationDate'];
    message = json?['message'];
    seen = json?['seen'];
    profilePicturePath = json?['profilePicturePath'];
  }

  late final String userId;
  late final String fullName;
  late final String? lastMessageSentAt;
  late final String message;
  late final bool seen;
  late final String? profilePicturePath;
}