import '../backend_request.dart';

class LoginRequest implements BackendRequest {
  final String email;
  final String password;
  final int language;

  LoginRequest({
    required this.email,
    required this.password,
    this.language = 0
  });

  @override
  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'language': language.toString()
  };
}