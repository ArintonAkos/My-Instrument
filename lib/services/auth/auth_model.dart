import 'package:my_instrument/shared/exceptions/uninitialized_exception.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'future_response.dart';

class AuthModel {
  SharedPreferences? prefs;
  String? userEmail;
  bool get isSignedIn => !(userEmail?.isEmpty ?? true);

  Future init() async {
    this.prefs = await SharedPreferences.getInstance();
    if (prefs?.getBool('signedIn') == true) {
      String? email = await prefs?.getString('userEmail');

      userEmail = email;
    }
  }

  Future<FutureResponse> signIn(String email, String password, { bool? rememberMe }) async {
    try {
      if (prefs == null) {
        throw new UninitializedException(CallerClass.SharedPreferences);
      }
      final user = ParseUser(email, password, null);
      var response = await user.login();

      if (response.success) {
        if (rememberMe == true) {
          this.prefs!.setString('userEmail', email);
          prefs!.setBool('signedIn', true);
        }
        this.userEmail = email;
      } else {
        return FutureResponse(exception: response.error);
      }
    } catch (e) {
      return FutureResponse(exception: e);
    }

    return FutureResponse();
  }

  Future<FutureResponse> signOut() async {
    try {
      var user = await ParseUser.currentUser();
      if (user != null) {
        user = user as ParseUser;
        var response = await user.logout();

        if (response.success) {
          if (prefs == null) {
            throw new UninitializedException(CallerClass.SharedPreferences);
          }
        } else {
          return FutureResponse(exception: response.error);
        }
      }
    } catch (e) {
      return FutureResponse(exception: e);
    }

    userEmail = null;
    prefs?.setString('userEmail', '');
    prefs?.setBool('signedIn', false);
    return FutureResponse();
  }
}