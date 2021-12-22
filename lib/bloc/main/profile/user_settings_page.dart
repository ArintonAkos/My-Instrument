import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';
import 'package:my_instrument/shared/widgets/card_item.dart';
import 'package:my_instrument/shared/widgets/info_snackbar.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:my_instrument/structure/route/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

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
                const UserCard(),
                const ActionsRow(),
                const Settings(settingsItems: _settingsItems)
              ].toColumn()),
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({Key? key}) : super(key: key);

  Widget _buildUserRow(BuildContext context) {
    return <Widget>[
      Icon(
        Icons.account_circle,
        color: Theme.of(context).colorScheme.onSurface,)
          .decorated(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(30),
      )
          .constrained(height: 50, width: 50)
          .padding(right: 10),
      <Widget>[
        const Text(
          'User Name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ).padding(bottom: 5),
        Text(
          'User role',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    ].toRow();
  }

  Widget _buildUserStats() {
    return <Widget>[
      _buildUserStatsItem('846', 'Collect'),
      _buildUserStatsItem('51', 'Attention'),
      _buildUserStatsItem('267', 'Track'),
      _buildUserStatsItem('39', 'Coupons'),
    ]
        .toRow(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(vertical: 10);
  }

  Widget _buildUserStatsItem(String value, String text) => <Widget>[
    Text(value).fontSize(20).textColor(Colors.white).padding(bottom: 5),
    Text(text).textColor(Colors.white.withOpacity(0.6)).fontSize(12),
  ].toColumn();

  @override
  Widget build(BuildContext context) {
    return <Widget>[_buildUserRow(context), _buildUserStats()]
        .toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(horizontal: 20, vertical: 10)
        .decorated(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20)
        )
        .elevation(
          5,
          shadowColor: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
        )
        .height(175)
        .alignment(Alignment.center);
  }
}

class ActionsRow extends StatelessWidget {
  const ActionsRow({Key? key}) : super(key: key);

  Widget _buildActionItem(String name, IconData icon, BuildContext context, { VoidCallback? onTap } ) {
    final Widget actionIcon = Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        splashRadius: 25.0,
          icon: Icon(icon,
            size: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        onPressed: onTap,
      ).ripple()
    );

    final Widget actionText = Text(
      name,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
        fontSize: 12,
      ),
    );

    return <Widget>[
      actionIcon,
      actionText,
    ].toColumn().padding(vertical: 20);
  }

  void _onThemeClick(ThemeNotifier themeNotifier) {
    switch (themeNotifier.getThemeName()) {
      case 'dark':
        themeNotifier.setLightMode();
        break;
      default:
        themeNotifier.setDarkMode();
        break;
    }
  }

  IconData _getThemeIcon(ThemeNotifier theme) {
    switch (theme.getThemeName()) {
      case 'dark':
        return Icons.dark_mode;
      default:
        return Icons.light_mode;
    }
  }

  @override
  Widget build(BuildContext context) => <Widget>[
    _buildActionItem('Wallet', Icons.attach_money, context),
    _buildActionItem('Delivery', Icons.card_giftcard, context),
    _buildActionItem('Message', Icons.message, context),
    _buildActionItem(
      AppLocalizations.of(context)!.translate('PROFILE.THEME_SWITCH_LABEL'),
      _getThemeIcon(Provider.of<ThemeNotifier>(context)),
      context,
      onTap: () =>
        _onThemeClick(Provider.of<ThemeNotifier>(context, listen: false))
    ),
  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround);
}

logoutUser(BuildContext context) {
  var authModel = AppInjector.get<AuthModel>();
  var result = authModel.signOut();

  if (!result.success) {
    ScaffoldMessenger.of(context).showSnackBar(
        buildInfoSnackBar(
          AppLocalizations.of(context)?.translate('SHARED.ERROR.LOGOUT_MESSAGE') ?? ''
        )
    );
  }
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

class Settings extends StatelessWidget {
  final List<CardItemModel> settingsItems;
  const Settings({
    Key? key,
    required this.settingsItems
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => settingsItems
      .map((settingsItem) => SettingsItem(
      icon: settingsItem.icon,
      iconBgColor: settingsItem.color,
      title: settingsItem.title,
      description: settingsItem.description,
      onTap: settingsItem.onTap,
  ))
      .toList()
      .toColumn();
}

class SettingsItem extends StatefulWidget {
  const SettingsItem({Key? key,
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.description,
    this.onTap
  }) : super (key: key);

  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;
  final Function(BuildContext context)? onTap;

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool pressed = false;

  settingsItem({required Widget child}) =>
    Styled.widget(child: child)
      .alignment(Alignment.center)
      .borderRadius(all: 15)
      .ripple()
      .backgroundColor(
        Theme.of(context).cardColor,
        animate: true
      )
      .clipRRect(all: 25) // clip ripple
      .borderRadius(all: 25, animate: true)
      .elevation(
        pressed
            ? 0
            : 20,
        borderRadius: BorderRadius.circular(25),
        shadowColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
      )
      .constrained(height: 80)
      .padding(vertical: 12) // margin
      .gestures(
        onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!(context);
          }
        },
      )
      .scale(all: pressed ? 0.95 : 1.0, animate: true)
      .animate(
        const Duration(milliseconds: 150),
        Curves.easeOut
      );

  @override
  Widget build(BuildContext context) {
    final Widget icon = Icon(widget.icon, size: 20, color: Colors.white)
        .padding(all: 12)
        .decorated(
      color: widget.iconBgColor,
      borderRadius: BorderRadius.circular(30),
    )
        .padding(left: 15, right: 10);

    final Widget title = Text(
      widget.title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ).padding(bottom: 5);

    final Widget description = Text(
      widget.description,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );

    return settingsItem(
      child: <Widget>[
        icon,
        <Widget>[
          title,
          description,
        ].toColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ].toRow(),
    );
  }
}
