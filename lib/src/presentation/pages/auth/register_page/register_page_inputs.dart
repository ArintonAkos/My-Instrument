import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:my_instrument/src/presentation/widgets/auth_pages_widgets.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:provider/provider.dart';

import 'account_name_inputs.dart';
import 'account_type_select.dart';

class RegisterPageInputs extends StatefulWidget {
  const RegisterPageInputs({
    Key? key
  }) : super(key: key);

  @override
  State<RegisterPageInputs> createState() => _RegisterPageInputsState();
}

class _RegisterPageInputsState extends State<RegisterPageInputs> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? accountType;
  bool accountTypeError = false;

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerCompanyName = TextEditingController();

  Widget _buildEmailTF() {
    return buildTF(
      AppLocalizations.of(context)!.translate('LOGIN.EMAIL_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('LOGIN.EMAIL_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      Icons.email_outlined,
      inputController: controllerEmail,
      textInputType: TextInputType.emailAddress,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
      validator: (v) {
        if (v == null || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(v)) {
          return AppLocalizations.of(context)!.translate('SHARED.ERROR.EMAIL_MESSAGE');
        }

        return null;
      }
    );
  }

  Widget _buildPasswordTF() {
    return buildTF(
      AppLocalizations.of(context)!.translate('REGISTER.PASSWORD_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('REGISTER.PASSWORD_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      Icons.lock_outlined,
      inputController: controllerPassword,
      obscureText: true,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
      validator: (v) {
        if (v == null || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(v)) {
          return AppLocalizations.of(context)!.translate('SHARED.ERROR.PASSWORD.VALID_MESSAGE');
        }

        return null;
      },
    );
  }

  Widget _buildConfirmPasswordTF() {
    return buildTF(
      AppLocalizations.of(context)!.translate('REGISTER.CONFIRM_PASSWORD_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('REGISTER.CONFIRM_PASSWORD_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      Icons.lock_outlined,
      inputController: controllerConfirmPassword,
      obscureText: true,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
      validator: (v) {
        if (v != controllerPassword.text) {
          return AppLocalizations.of(context)!.translate('SHARED.ERROR.CONFIRM_PASSWORD_MESSAGE');
        }

        return null;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          'assets/auth/register.svg',
          height: 350
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            AppLocalizations.of(context)!.translate('REGISTER.BUTTON'),
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            )
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.translate("REGISTER.SUB_TITLE"),
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
            ),
          ),
        ),
        const SizedBox(height: 15,),
        Form(
          key: _formKey,
          child: Column(
            children: [
              _buildEmailTF(),
              const SizedBox(height: 20,),
              _buildPasswordTF(),
              const SizedBox(height: 20,),
              _buildConfirmPasswordTF(),
              const SizedBox(height: 20,),
              AccountTypeSelect(
                accountType: accountType,
                onSelect: (v) {
                  setState(() { accountType = v; });
                },
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: (accountTypeError)
                ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.translate('SHARED.ERROR.EMPTY_FIELD_MESSAGE'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                      fontSize: 12
                    ),
                  ),
                )
                : const SizedBox(height: 0,)
              ),
              const SizedBox(height: 20,),
              AccountNameInputs(
                accountType: accountType,
                controllerCompanyName: controllerCompanyName,
                controllerFirstName: controllerFirstName,
                controllerLastName: controllerLastName,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5, left: 5, right: 5),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.translate('REGISTER.INFO_TEXT.FIRST_ELEMENT')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.translate('REGISTER.INFO_TEXT.SECOND_ELEMENT'),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                        )
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.translate('REGISTER.INFO_TEXT.THIRD_ELEMENT'),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.translate('REGISTER.INFO_TEXT.FOURTH_ELEMENT'),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                        )
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.translate('REGISTER.INFO_TEXT.FIFTH_ELEMENT'),
                      )
                    ]
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (validate()) {
                /*context.read<LoginPageBloc>().add(
                  LoginUserWithEmail(
                    email: controllerEmail.text,
                    password: controllerPassword.text
                  )
                );*/
              }
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.bold
                ),
                shadowColor: Theme.of(context).colorScheme.primary
            ),
            child: Text(
              AppLocalizations.of(context)!.translate('SHARED.INFO.SUBMIT')
            )
          ),
        ),
        const SizedBox(height: 25,)
      ],
    );
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerConfirmPassword.dispose();
    controllerFirstName.dispose();
    controllerLastName.dispose();
    controllerCompanyName.dispose();

    super.dispose();
  }

  bool validate() {
    bool accountTypeOk = true;

    if (accountType == null) {
      accountTypeError = true;
      accountTypeOk = false;
    } else {
      accountTypeError = false;
    }


    bool inputsOk = _formKey.currentState!.validate();

    setState(() {});
    return (inputsOk && accountTypeOk);
  }
}
