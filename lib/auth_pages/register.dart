import 'package:flutter/material.dart';
import 'package:my_instrument/translation/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                AppLocalizations.of(context)!.translate('MESSAGES.TITLE')
            ),
          ],
        ),
      );
  }
}