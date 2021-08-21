import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel extends ChangeNotifier {
  int? currentUser = null;

  bool get isSignedIn => currentUser != null;

  Future init() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('signedIn') == true) {
      currentUser = 1;
    }
  }

  Future<void> signIn(//{required String email, required String password}
    ) async {
    // await _auth.signInWithEmailAndPassword(email: email, password: password);
    var prefs = await SharedPreferences.getInstance();

    currentUser = 1;
    prefs.setBool('signedIn', true);
    notifyListeners();
  }

  Future<void> signOut() async {
    // await _auth.signOut();
    var prefs = await SharedPreferences.getInstance();

    currentUser = null;
    prefs.setBool('signedIn', false);
    notifyListeners();
  }
}