import 'package:flutter/material.dart';
import 'package:my_instrument/base/base_page.dart';
import 'package:my_instrument/navigation/bottom_nav_bar_props.dart';
import 'package:my_instrument/translation/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with BasePage
    implements IPageNavbar {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      this.showNavBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                AppLocalizations.of(context)!.translate('HOME.TITLE')
            ),
          ],
        ),
      );
  }

  @override
  void showNavBar() {
    super.ShowNavBar(context.read<BottomNavBarProps>());
  }

}