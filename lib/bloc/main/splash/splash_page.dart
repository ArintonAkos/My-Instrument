import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/services/auth/server_constants.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class SplashPage extends StatelessWidget {
  late final AuthModel authModel;

  SplashPage() {
    this.authModel = Modular.get<AuthModel>();
    _init();
  }

  void _init() async {
    await authModel.init();
    await Parse().initialize(
        ServerConstants.APPLICATION_ID,
        ServerConstants.PARSE_SERVER_URL,
        clientKey: ServerConstants.CLIENT_KEY,
        debug: false
    );
    Modular.to.navigate('/home/');
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