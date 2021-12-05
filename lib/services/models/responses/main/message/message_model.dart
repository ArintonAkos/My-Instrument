class MessageModel {
  Map<String, dynamic>? json;

  MessageModel({ required this.json }) {
    userId = json?['id'];
    fullName = json?['fullName'];
    lastMessageSentAt = json?['lastMessageSentAt'];
    message = json?['message'];
    seen = json?['seen'];
    profilePicturePath = json?['profilePicturePath'];
  }

  late final int? userId;
  late final String fullName;
  late final DateTime lastMessageSentAt;
  late final String message;
  late final bool seen;
  late final String profilePicturePath;
}