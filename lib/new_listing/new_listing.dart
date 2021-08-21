import 'package:flutter/material.dart';
import 'package:my_instrument/base/base_page.dart';
import 'package:my_instrument/navigation/bottom_nav_bar_props.dart';
import 'package:my_instrument/translation/app_localizations.dart';
import 'package:provider/provider.dart';

class NewListingPage extends StatefulWidget {
  const NewListingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage> with BasePage
    implements IPageNavbar {

  @override
  void initState() {
    super.initState();
    this.showNavBar();
  }

  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                AppLocalizations.of(context)!.translate('NEW_LISTING.TITLE')
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