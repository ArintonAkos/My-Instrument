import 'package:flutter/cupertino.dart';
import 'package:my_instrument/src/data/data_providers/services/shared_prefs.dart';
import 'package:my_instrument/src/presentation/pages/main/splash_page/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitializeNotifier with ChangeNotifier {
  bool boardingCompleted = false;
  bool initialized = false;


  void init(SplashPage widget, BuildContext context) async {
    await widget.authModel.init();
    await widget.signalRService.startService();
    boardingCompleted = SharedPrefs.instance.getBool('boardingCompleted') ?? false;
    initialized = true;
    notifyListeners();
  }

  void setBoardingCompleted(bool boardingCompleted) async {
    if (boardingCompleted != this.boardingCompleted) {
      SharedPrefs.instance.setBool('boardingCompleted', boardingCompleted);
      this.boardingCompleted = boardingCompleted;
      notifyListeners();
    }
  }
}