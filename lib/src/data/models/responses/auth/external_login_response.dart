
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
  String? name;
  String? firstName;
  String? lastName;

  ExternalLoginResponse({
    required this.loginStatus,
    this.email,
    this.accessToken,
    this.id,
    this.name,
    this.firstName,
    this.lastName
  });

}