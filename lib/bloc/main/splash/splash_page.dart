import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  late final AuthModel authModel;

  SplashPage() {
    this.authModel = Modular.get<AuthModel>();
    _init();
  }

  void _init() async {
    await authModel.init();
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('boardingCompleted') == true) {
      Modular.to.navigate('/home/');
    } else {
      Modular.to.navigate('/onboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Text('Splash screen',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface
          ),
          textAlign: TextAlign.center,
        )
      )
    );
  }

}