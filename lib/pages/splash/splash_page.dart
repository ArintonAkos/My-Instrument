import 'package:flutter/material.dart';
import 'package:my_instrument/screens/splash/splash_screen.dart';

class SplashPage extends Page {

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return SplashScreen();
      },
    );
  }
}