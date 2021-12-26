
enum ExternalLoginStatus {
  succeeded,
  emailRequired,
  failed
}

class ExternalLoginResponse {
  ExternalLoginStatus loginStatus;
  String? email;
  String? accessToken;
  String? id;

  ExternalLoginResponse({
    required this.loginStatus,
    this.email,
    this.accessToken,
    this.id
  });

}