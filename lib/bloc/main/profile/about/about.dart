import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';
import 'package:my_instrument/shared/widgets/card_item.dart';

import '../user_settings_page.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate('PROFILE.ABOUT.TITLE'),
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Settings(settingsItems: _getAboutCards(context))
        )
      ),
    );
  }

}

_getAboutCards(BuildContext context) {
  List<CardItemModel> aboutCards = [
    CardItemModel(
      icon: Icons.article,
      color: Color(0xfffc5c65),
      title: AppLocalizations.of(context)!.translate('PROFILE.ABOUT.LICENSES.TITLE'),
      description: AppLocalizations.of(context)!.translate('PROFILE.ABOUT.LICENSES.DESCRIPTION'),
    ),
    CardItemModel(
      icon: Icons.gavel,
      color: Color(0xff45aaf2),
      title: AppLocalizations.of(context)!.translate('PROFILE.ABOUT.TERMS_OF_SERVICE.TITLE'),
      description: AppLocalizations.of(context)!.translate('PROFILE.ABOUT.TERMS_OF_SERVICE.DESCRIPTION'),
    ),
    CardItemModel(
      icon: Icons.lock,
      color: Color(0xff26de81),
      title: AppLocalizations.of(context)!.translate('PROFILE.ABOUT.PRIVACY_POLICY.TITLE'),
      description: AppLocalizations.of(context)!.translate('PROFILE.ABOUT.PRIVACY_POLICY.DESCRIPTION'),
    ),
  ];

  return aboutCards;
}