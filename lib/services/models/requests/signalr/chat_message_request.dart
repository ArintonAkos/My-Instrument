class ChatMessageRequest {
  final String user;
  final String message;

  ChatMessageRequest(this.user, this.message);

  Map<String, dynamic> toJson() {
    return {
      'User': user,
      'Message': message
    };
  }
}