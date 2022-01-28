import 'package:flutter/material.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/presentation/widgets/basic_page_app_bar.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getBasicPageAppBar(
        context,
        AppLocalizations.of(context)!.translate('PROFILE.GENERAL_SETTINGS.LANGUAGES.TITLE')
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: ListTile.divideTiles(
            context: context,
            tiles: List.generate(
              localisations.length,
              (index) => ListTile(
                title: Text(
                  AppLocalizations.of(context)!.translate('APP_LOCALIZATIONS.${localisations[index]}'),
                ),
                trailing: SizedBox(
                  width: 40,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: isActiveLocale(context, index)
                      ? const Icon(
                        Icons.check
                      )
                      : null
                  ),
                ),
                onTap: () => updateLocale(context, index),
              ),
            ),
          ).toList(),
        ),
      )
    );
  }

  bool isActiveLocale(BuildContext context, int index) {
    var appLanguage = Provider.of<AppLanguage>(context, listen: false);

    return (appLanguage.appLocale.languageCode == AppLanguage.getLocaleByName(localisations[index]).languageCode);
  }

  void updateLocale(BuildContext context, int index) {
    var appLanguage = Provider.of<AppLanguage>(context, listen: false);

    appLanguage.changeLanguage(AppLanguage.getLocaleByName(localisations[index]));
  }
}
