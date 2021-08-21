import 'package:flutter/cupertino.dart';

class AuthModel extends ChangeNotifier {
  int? currentUser = null;

  bool get isSignedIn => currentUser != null;

  Future<void> signIn(//{required String email, required String password}
    ) async {
    // await _auth.signInWithEmailAndPassword(email: email, password: password);
    currentUser = 1;
    notifyListeners();
  }

  Future<void> signOut() async {
    // await _auth.signOut();
    currentUser = null;
    notifyListeners();
  }
}