import 'package:flutter/material.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:my_instrument/src/presentation/widgets/auth_pages_widgets.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:provider/provider.dart';

class AccountNameInputs extends StatelessWidget {
  final int? accountType;
  final TextEditingController controllerFirstName;
  final TextEditingController controllerLastName;
  final TextEditingController controllerCompanyName;

  const AccountNameInputs({
    Key? key,
    required this.accountType,
    required this.controllerFirstName,
    required this.controllerLastName,
    required this.controllerCompanyName
  }) : super(key: key);

  Widget _buildFirstNameTF(BuildContext context) {
    return buildTF(
      AppLocalizations.of(context)!.translate('REGISTER.FIRST_NAME_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('REGISTER.FIRST_NAME_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      Icons.person_outline_rounded,
      inputController: controllerFirstName,
      textInputType: TextInputType.text,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
      validator: (v) {
        if (accountType == 0) {
          return AppLocalizations.of(context)!.translate('SHARED.ERROR.EMPTY_FIELD_MESSAGE');
        }

        return null;
      }
    );
  }

  Widget _buildLastNameTF(BuildContext context) {
    return buildTF(
      AppLocalizations.of(context)!.translate('REGISTER.LAST_NAME_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('REGISTER.LAST_NAME_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      Icons.person_outline_rounded,
      inputController: controllerLastName,
      textInputType: TextInputType.text,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
      validator: (v) {
        if (accountType == 0) {
          return AppLocalizations.of(context)!.translate('SHARED.ERROR.EMPTY_FIELD_MESSAGE');
        }

        return null;
      }
    );
  }

  Widget _buildCompanyNameTF(BuildContext context) {
    return buildTF(
      AppLocalizations.of(context)!.translate('REGISTER.COMPANY_NAME_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('REGISTER.COMPANY_NAME_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      Icons.business_outlined,
      inputController: controllerCompanyName,
      textInputType: TextInputType.text,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
      validator: (v) {
        if (accountType == 1) {
          return AppLocalizations.of(context)!.translate('SHARED.ERROR.EMPTY_FIELD_MESSAGE');
        }

        return null;
      }
    );
  }

  Widget getChildByAccountType(BuildContext context) {
    if (accountType == 0) {
      return Column(
        key: const ValueKey<int>(0),
        children: [
          _buildFirstNameTF(context),
          const SizedBox(height: 20),
          _buildLastNameTF(context)
        ],
      );
    } else if (accountType == 1) {
      return Container(
        key: const ValueKey<int>(1),
        child: _buildCompanyNameTF(context),
      );
    }

    return const SizedBox(
      key: ValueKey<int>(2),
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: getChildByAccountType(context),
    );
  }
}
