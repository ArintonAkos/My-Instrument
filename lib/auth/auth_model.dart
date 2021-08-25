import 'package:flutter/cupertino.dart';
import 'package:my_instrument/auth/future_response.dart';
import 'package:my_instrument/auth/server_constants.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel extends ChangeNotifier {

  String? userEmail;
  bool get isSignedIn => userEmail?.isEmpty ?? false;

  Future init() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('signedIn') == true) {
      String? email = await prefs.getString('userEmail');

      userEmail = email;
    }
  }

  Future<FutureResponse> signIn(String email, String password) async {
    try {
      final user = ParseUser(email, password, null);
      var response = await user.login();

      if (response.success) {
        var prefs = await SharedPreferences.getInstance();

        prefs.setString('userEmail', email);
        prefs.setBool('signedIn', true);
        notifyListeners();
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
      final user = ParseUser.currentUser() as ParseUser;
      var response = await user.logout();

      if (response.success) {
        var prefs = await SharedPreferences.getInstance();

        prefs.setString('userEmail', '');
        prefs.setBool('signedIn', false);
        notifyListeners();
      } else {
        return FutureResponse(exception: response.error);
      }

    } catch (e) {
      return FutureResponse(exception: e);
    }
    return FutureResponse();
  }
}