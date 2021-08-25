import 'package:flutter/material.dart';
import 'package:my_instrument/translation/app_localizations.dart';
import 'package:provider/provider.dart';

class NewListingPage extends StatefulWidget {
  const NewListingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage> {

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

}