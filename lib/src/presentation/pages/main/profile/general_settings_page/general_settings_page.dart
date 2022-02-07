import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/data/models/view_models/card_item_model.dart';
import 'package:my_instrument/src/presentation/widgets/basic_page_app_bar.dart';
import 'package:my_instrument/src/presentation/widgets/settings/settings.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/structure/route/router.gr.dart';

class GeneralSettingsPage extends StatelessWidget {
  const GeneralSettingsPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getBasicPageAppBar(
        context,
        AppLocalizations.of(context)!.translate('PROFILE.GENERAL_SETTINGS.TITLE')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Settings(
          settingsItems: [
            CardItemModel(
              icon: LineIcons.language,
              color: const Color(0xFF06B2BB),
              title: AppLocalizations.of(context)!.translate('PROFILE.GENERAL_SETTINGS.LANGUAGES.TITLE',),
              description: AppLocalizations.of(context)!.translate('PROFILE.GENERAL_SETTINGS.LANGUAGES.DESCRIPTION',),
              onTap: (_) {
                AutoRouter.of(context).push(const LanguageRoute());
              }
            ),
          ],
        ),
      ),
    );
  }
}
