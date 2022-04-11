import 'package:my_instrument/src/data/models/requests/backend_request.dart';

class ChangePasswordRequest implements BackendRequest {
  final String email;
  final String token;
  final String newPassword;

  const ChangePasswordRequest({
    required this.email,
    required this.token,
    required this.newPassword
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, String>{
      'email': email,
      'token': token,
      'newPassword': newPassword
    };
  }
}