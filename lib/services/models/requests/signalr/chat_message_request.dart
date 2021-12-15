class ChatMessageRequest {
  final String User;
  final String Message;

  ChatMessageRequest(this.User, this.Message);

  Map<String, dynamic> toJson() {
    return {
      'User': User,
      'Message': Message
    };
  }
}