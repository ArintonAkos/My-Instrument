import 'package:flutter/material.dart';
import 'package:my_instrument/base/base_page.dart';
import 'package:my_instrument/navigation/bottom_nav_bar_props.dart';
import 'package:my_instrument/translation/app_localizations.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with BasePage
    implements IPageNoNavbar {

  @override
  void initState() {
    super.initState();
    this.hideNavBar();
  }

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

  @override
  void hideNavBar() {
    super.HideNavBar(context.read<BottomNavBarProps>());
  }
}