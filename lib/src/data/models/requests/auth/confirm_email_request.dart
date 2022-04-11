class ConfirmEmailRequest {
  final String email;
  final String pin;
  final String confirmEmailId;

  const ConfirmEmailRequest({
    required this.email,
    required this.pin,
    required this.confirmEmailId
  });

  @override
  String toString() {
    return '?email=$email&pin=$pin&confirmEmailId=$confirmEmailId';
  }
}