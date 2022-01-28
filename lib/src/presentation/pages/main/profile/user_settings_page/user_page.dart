import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/auth_model.dart';
import 'package:my_instrument/src/presentation/pages/main/profile/user_settings_page/user_card.dart';
import 'package:my_instrument/src/presentation/widgets/settings/settings.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/src/data/models/view_models/card_item_model.dart';
import 'package:my_instrument/src/presentation/widgets/info_snackbar.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:my_instrument/structure/route/router.gr.dart';
import 'package:styled_widget/styled_widget.dart';

import 'actions_row.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  final AuthModel _authModel = appInjector.get<AuthModel>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (
            <Widget>[
              Text(
                AppLocalizations.of(context)!.translate('PROFILE.TITLE'),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ).alignment(Alignment.center).padding(bottom: 20),
              UserCard(authModel: _authModel),
              const ActionsRow(),
              const Settings(settingsItems: _settingsItems)
            ].toColumn()
          ),
        ),
      ),
    );
  }
}

logoutUser(BuildContext context) async {
  var authModel = appInjector.get<AuthModel>();
  var result = await authModel.signOut();

  if (!result.success) {
    ScaffoldMessenger.of(context).showSnackBar(
        buildInfoSnackBar(
            AppLocalizations.of(context)?.translate('SHARED.ERROR.LOGOUT_MESSAGE') ?? ''
        )
    );
  }
}

navigateToGeneralSettingsPage(BuildContext context) {
  AutoRouter.of(context).push(const EmptyRouterRoute(children: [ GeneralSettingsRoute() ]));
}

navigateToAboutPage(BuildContext context) {
  AutoRouter.of(context).push(const AboutRoute());
}

const List<CardItemModel> _settingsItems = [
  CardItemModel(
    icon: Icons.location_on,
    color: Color(0xff8D7AEE),
    title: 'Address',
    description: 'Ensure your harvesting address',
  ),
  CardItemModel(
    icon: Icons.lock,
    color: Color(0xffF468B7),
    title: 'Privacy',
    description: 'System permission change',
  ),
  CardItemModel(
    icon: Icons.menu,
    color: Color(0xffFEC85C),
    title: 'General',
    description: 'Basic functional settings',
    onTap: navigateToGeneralSettingsPage
  ),
  CardItemModel(
    icon: Icons.notifications,
    color: Color(0xff5FD0D3),
    title: 'About',
    description: 'Terms of Service and licenses',
    onTap: navigateToAboutPage
  ),
  CardItemModel(
    icon: Icons.question_answer,
    color: Color(0xffBFACAA),
    title: 'Support',
    description: 'We are here to help',
  ),
  CardItemModel(
    icon: Icons.logout,
    color: Color(0xff1ABC9C),
    title: 'Sign out',
    description: 'Sign out of and return to login page',
    onTap: logoutUser
  ),
];