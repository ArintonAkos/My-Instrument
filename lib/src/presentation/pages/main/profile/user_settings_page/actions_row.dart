import 'package:flutter/material.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

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
      const SizedBox(height: 7),
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