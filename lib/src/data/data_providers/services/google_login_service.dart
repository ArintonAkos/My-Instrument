import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_instrument/src/data/models/responses/auth/external_login_response.dart';


class GoogleLoginService {
  final List<String> scopes = [ 'email' ];

  late final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: scopes
  );

  Future<GoogleSignInAccount?> _signIn() => _googleSignIn.signIn();

  Future<ExternalLoginResponse> authenticateInDb() async {
    try {
      var res = await _signIn();
      final authentication = await res?.authentication;

      if (authentication != null) {
        return ExternalLoginResponse(
          loginStatus: ExternalLoginStatus.succeeded,
          email: res?.email,
          accessToken: authentication.idToken,
          id: res?.id
        );
      } else {
        throw Exception("Authentication couldn't be null!");
      }
    } catch (error) {
      return ExternalLoginResponse(loginStatus: ExternalLoginStatus.failed);
    }
  }

  Future<GoogleSignInAccount?> signOut() => _googleSignIn.signOut();
}