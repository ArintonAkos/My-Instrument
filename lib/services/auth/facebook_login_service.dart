import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:my_instrument/services/models/responses/auth/external_login_response.dart';

class FacebookLoginService {
  final List<String> permissions = ['email'];

  Future<LoginResult> _login() => FacebookAuth
      .instance
      .login(permissions: permissions);

  Future<ExternalLoginResponse> authenticateInDb() async {
    final result = await _login();
    if (result.status == LoginStatus.success) {
      Map<String, dynamic> data = await FacebookAuth.i.getUserData(fields: 'email');

      if (data['email'] != null) {
        return ExternalLoginResponse(
          loginStatus: ExternalLoginStatus.succeeded,
          email: data['email'],
          accessToken: result.accessToken?.token ?? '',
          id: data['id'],
        );
      }
    }

    return ExternalLoginResponse(loginStatus: ExternalLoginStatus.failed);
  }

  Future<void> signOut() => FacebookAuth.i.logOut();
}