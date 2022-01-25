import 'package:flutter/cupertino.dart';
import 'package:my_instrument/src/presentation/pages/main/splash_page/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitializeNotifier with ChangeNotifier {
  bool boardingCompleted = false;
  bool initialized = false;


  void init(SplashPage widget, BuildContext context) async {
    await widget.authModel.init();
    var prefs = await SharedPreferences.getInstance();
    await widget.signalRService.startService();
    boardingCompleted = prefs.getBool('boardingCompleted') ?? false;
    initialized = true;
    notifyListeners();
  }

  void setBoardingCompleted(bool boardingCompleted) async {
    if (boardingCompleted != this.boardingCompleted) {
      var prefs = await SharedPreferences.getInstance();
      prefs.setBool('boardingCompleted', boardingCompleted);
      this.boardingCompleted = boardingCompleted;
      notifyListeners();
    }
  }
}