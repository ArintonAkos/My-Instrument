import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_instrument/shared/data/page_data.dart';
import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';
import 'package:my_instrument/shared/widgets/custom_dialog.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import 'auth_pages_constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerCompanyName = TextEditingController();

  int _accountType = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Provider.of<ThemeNotifier>(context).getTheme()!.customTheme.LoginGradientStart,
                      Provider.of<ThemeNotifier>(context).getTheme()!.customTheme.LoginGradientEnd,
                    ],
                    stops: [0.1, 0.9],
                  ),
                ),
              ),
              Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 100.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.translate('REGISTER.REGISTER_HEADER_TEXT'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                              )
                          ),
                          SizedBox(height: 30.0,),
                          _buildEmailTF(),
                          SizedBox(height: 30.0,),
                          _buildPasswordTF(),
                          SizedBox(height: 30.0,),
                          _buildConfirmPasswordTF(),
                          SizedBox(height: 30.0,),
                          buildDropDownInput(context,
                            PageData.AccountTypes,
                            _accountType,
                            (String? value) {
                              setState(() {
                                var ind = PageData.AccountTypes.indexOf(value.toString());
                                _accountType = ind > -1 ? ind : 0;
                              });
                            },
                            inputLabel: AppLocalizations.of(context)!.
                            translate('REGISTER.ACCOUNT_TYPE_LABEL')
                          ),
                          ..._buildAdditionalInfoTF(),
                          SizedBox(height: 30.0,),
                          _buildRegisterBtn()
                        ],
                      )
                  )
              )
            ],
          ),
        )
      ),
    );
  }

  Widget _buildEmailTF() {
    return buildTF(
        AppLocalizations.of(context)!.translate('REGISTER.EMAIL_INPUT_LABEL'),
        AppLocalizations.of(context)!.translate('REGISTER.EMAIL_INPUT_TEXT'),
        Provider.of<ThemeNotifier>(context).getTheme(),
        inputController: controllerEmail,
        textInputType: TextInputType.emailAddress
    );
  }

  Widget _buildPasswordTF() {
    return buildTF(
        AppLocalizations.of(context)!.translate('REGISTER.PASSWORD_INPUT_LABEL'),
        AppLocalizations.of(context)!.translate('REGISTER.PASSWORD_INPUT_TEXT'),
        Provider.of<ThemeNotifier>(context).getTheme(),
        inputController: controllerPassword,
        obscureText: true
    );
  }

  Widget _buildConfirmPasswordTF() {
    return buildTF(
      AppLocalizations.of(context)!.translate('REGISTER.CONFIRM_PASSWORD_INPUT_LABEL'),
      AppLocalizations.of(context)!.translate('REGISTER.CONFIRM_PASSWORD_INPUT_TEXT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      inputController: controllerConfirmPassword,
      obscureText: true
    );
  }

  Widget _buildRegisterBtn() {
    return buildAuthButton(
      AppLocalizations.of(context)!.translate('REGISTER.REGISTER_BUTTON'),
      Provider.of<ThemeNotifier>(context).getTheme()?.customTheme,
      onPressed: _register,
      disabled: false,
    );
  }

  Widget _buildFirstNameTF() {
    return buildTF(
        AppLocalizations.of(context)!.translate('REGISTER.FIRST_NAME_INPUT_LABEL'),
        AppLocalizations.of(context)!.translate('REGISTER.FIRST_NAME_INPUT_TEXT'),
        Provider.of<ThemeNotifier>(context).getTheme(),
        inputController: controllerFirstName,
        textInputType: TextInputType.text
    );
  }

  Widget _buildLastNameTF() {
    return buildTF(
        AppLocalizations.of(context)!.translate('REGISTER.LAST_NAME_INPUT_LABEL'),
        AppLocalizations.of(context)!.translate('REGISTER.LAST_NAME_INPUT_TEXT'),
        Provider.of<ThemeNotifier>(context).getTheme(),
        inputController: controllerLastName,
        textInputType: TextInputType.text
    );
  }

  Widget _buildCompanyNameTF() {
    return buildTF(
        AppLocalizations.of(context)!.translate('REGISTER.COMPANY_NAME_INPUT_LABEL'),
        AppLocalizations.of(context)!.translate('REGISTER.COMPANY_NAME_INPUT_TEXT'),
        Provider.of<ThemeNotifier>(context).getTheme(),
        inputController: controllerCompanyName,
        textInputType: TextInputType.text
    );
  }

  List<Widget> _buildAdditionalInfoTF() {
    if (_accountType == 0) {
      return [
        SizedBox(height: 20.0,),
        _buildFirstNameTF(),
        SizedBox(height: 20.0,),
        _buildLastNameTF(),
      ];
    } else {
      return [
        SizedBox(height: 20.0),
        _buildCompanyNameTF()
      ];
    }
  }

  _register() async {
    final username = controllerEmail.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();
    final confirmPassword =  controllerConfirmPassword.text.trim();
    final firstName = controllerFirstName.text.trim();
    final lastName = controllerLastName.text.trim();
    final companyName = controllerCompanyName.text.trim();

    if (!validateFields(email, password, confirmPassword, firstName, lastName, companyName)) {

    }
    final user = ParseUser.createUser(username, password, email);

    user.set('accountType', _accountType);
    if (_accountType == 1) {
      user.set('companyName', companyName);
    } else {
      user.set('firstName', firstName);
      user.set('lastName', lastName);
    }


    var response = await user.signUp();

    if (response.success) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) => CustomDialog(
          description: 'User successfully created! Please return to login page and log in to your account.',
          dialogType: DialogType.Success,
        )
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) => CustomDialog(
          description: 'An error occurred, please try again later!',
          dialogType: DialogType.Failure,
        )
      );
    }
  }

  bool validateFields(String email, String password, String confirmPassword,
      String firstName, String lastName, String companyName) {
    return true;

    if (password != confirmPassword) {
      return false;
    }

    if (_accountType == 1) {
      if (companyName == "") {
        return false;
      }
    } else if (_accountType == 0) {
      if (firstName == "") {
        return false;
      } else if (lastName == "") {
        return false;
      }
    } else {
      return false;
    }
  }
}