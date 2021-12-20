import 'package:flutter/cupertino.dart';
import 'package:my_instrument/bloc/main/splash/splash_page.dart';
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
}