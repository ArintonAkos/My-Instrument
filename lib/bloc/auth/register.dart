import 'package:flutter/material.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Scaffold(
          body: Center(
            child: InkWell(
              child: Text(
                AppLocalizations.of(context)!.translate('MESSAGES.TITLE')
              ),
              onTap: () {
                // context.router.root.push(LoginRoute(updateActiveScreen: widget.updateActiveScreen,));
                // widget.updateActiveScreen(ActiveScreen.Login);
              },
            )
          ),
        ),
      );
  }
}