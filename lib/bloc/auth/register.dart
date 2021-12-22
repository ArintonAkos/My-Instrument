import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/services/models/requests/auth/register_request.dart';
import 'package:my_instrument/shared/data/page_data.dart';
import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:my_instrument/shared/translation/app_language.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';
import 'package:my_instrument/shared/widgets/custom_dialog.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:my_instrument/structure/route/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
  String? emailErrorText,
      passwordErrorText,
      confirmPasswordErrorText,
      firstNameErrorText,
      lastNameErrorText,
      companyNameErrorText;

  int _accountType = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: WaveWidget(
                  config: CustomConfig(
                    colors: [
                      Provider.of<ThemeNotifier>(context).getTheme()!.customTheme.authPagesPrimaryColors[0],
                      Provider.of<ThemeNotifier>(context).getTheme()!.customTheme.authPagesPrimaryColors[1],
                      Provider.of<ThemeNotifier>(context).getTheme()!.customTheme.authPagesPrimaryColors[2],
                      Provider.of<ThemeNotifier>(context).getTheme()!.customTheme.authPagesPrimaryColors[3]
                    ],
                    durations: [18000, 8000, 5000, 12000],
                    heightPercentages: [0.59, 0.61, 0.63, 0.65],
                    blur: const MaskFilter.blur(BlurStyle.solid, 10.0),
                  ),
                  size: const Size(double.infinity, double.infinity),
                  backgroundColor: Provider.of<ThemeNotifier>(context).getTheme()!.customTheme.loginGradientStart,
                  waveAmplitude: 1,
                ),
              ),
              SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 100.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: [
                              Positioned(
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      onPressed: () {
                                        AutoRouter.of(context).replace(const LoginRoute());
                                      },
                                      icon: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.white
                                      )
                                    ),
                                  ),
                                ),
                                left: 0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                                child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('REGISTER.HEADER_TEXT'),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                )
                              ),
                            ],
                          ),
                          const SizedBox(height: 15.0,),
                          _buildEmailTF(),
                          const SizedBox(height: 15.0,),
                          _buildPasswordTF(),
                          const SizedBox(height: 15.0,),
                          _buildConfirmPasswordTF(),
                          const SizedBox(height: 15.0,),
                          buildDropDownInput(context,
                            PageData.getAccountTypes(Provider.of<AppLanguage>(context)),
                            _accountType,
                            (String? value) {
                              setState(() {
                                var ind = PageData.getAccountTypes(Provider.of<AppLanguage>(context))
                                    .indexOf(value.toString());
                                _accountType = ind > -1 ? ind : 0;
                              });
                            },
                            inputLabel: AppLocalizations.of(context)!.
                            translate('REGISTER.ACCOUNT_TYPE_LABEL')
                          ),
                          ..._buildAdditionalInfoTF(),
                          const SizedBox(height: 15.0,),
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
        AppLocalizations.of(context)!.translate('REGISTER.EMAIL_INPUT.LABEL'),
        AppLocalizations.of(context)!.translate('REGISTER.EMAIL_INPUT.HINT'),
        Provider.of<ThemeNotifier>(context).getTheme(),
        Icons.email_outlined,
        inputController: controllerEmail,
        textInputType: TextInputType.emailAddress,
        errorText: emailErrorText
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
        errorText: passwordErrorText
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
      errorText: confirmPasswordErrorText
    );
  }

  Widget _buildRegisterBtn() {
    return buildAuthButton(
      AppLocalizations.of(context)!.translate('REGISTER.BUTTON'),
      Provider.of<ThemeNotifier>(context).getTheme()?.customTheme,
      onPressed: _register,
      disabled: false,
    );
  }

  Widget _buildFirstNameTF() {
    return buildTF(
        AppLocalizations.of(context)!.translate('REGISTER.FIRST_NAME_INPUT.LABEL'),
        AppLocalizations.of(context)!.translate('REGISTER.FIRST_NAME_INPUT.HINT'),
        Provider.of<ThemeNotifier>(context).getTheme(),
        Icons.person_outline_rounded,
        inputController: controllerFirstName,
        textInputType: TextInputType.text,
        errorText: firstNameErrorText
    );
  }

  Widget _buildLastNameTF() {
    return buildTF(
        AppLocalizations.of(context)!.translate('REGISTER.LAST_NAME_INPUT.LABEL'),
        AppLocalizations.of(context)!.translate('REGISTER.LAST_NAME_INPUT.HINT'),
        Provider.of<ThemeNotifier>(context).getTheme(),
        Icons.person_outline_rounded,
        inputController: controllerLastName,
        textInputType: TextInputType.text,
        errorText: lastNameErrorText
    );
  }

  Widget _buildCompanyNameTF() {
    return buildTF(
        AppLocalizations.of(context)!.translate('REGISTER.COMPANY_NAME_INPUT.LABEL'),
        AppLocalizations.of(context)!.translate('REGISTER.COMPANY_NAME_INPUT.HINT'),
        Provider.of<ThemeNotifier>(context).getTheme(),
        Icons.business_outlined,
        inputController: controllerCompanyName,
        textInputType: TextInputType.text,
        errorText: companyNameErrorText
    );
  }

  List<Widget> _buildAdditionalInfoTF() {
    if (_accountType == 0) {
      return [
        const SizedBox(height: 30.0,),
        _buildFirstNameTF(),
        const SizedBox(height: 10.0,),
        _buildLastNameTF(),
      ];
    } else {
      return [
        const SizedBox(height: 30.0),
        _buildCompanyNameTF()
      ];
    }
  }

  _register() async {
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();
    final confirmPassword =  controllerConfirmPassword.text.trim();
    final firstName = controllerFirstName.text.trim();
    final lastName = controllerLastName.text.trim();
    final companyName = controllerCompanyName.text.trim();

    if (!validateFields(email, password, confirmPassword, firstName, lastName, companyName)) {
      return;
    }

    RegisterRequest request = RegisterRequest(
      email: email,
      password: password,
      accountType: _accountType,
    );

    if (_accountType == 1) {
      request.companyName = companyName;
    } else {
      request.firstName =  firstName;
      request.lastName = lastName;
    }

    AuthModel authModel = appInjector.get<AuthModel>();
    var response = await authModel.register(request);

    if (response.success) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) => CustomDialog(
          onAccept: () {
            AutoRouter.of(context).replace(const LoginRoute());
          },
          description: AppLocalizations.of(context)!.translate('REGISTER.ACCOUNT_CREATION_LABEL.SUCCESSFUL'),
          dialogType: DialogType.success,
        )
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) => CustomDialog(
          description: AppLocalizations.of(context)!.translate('REGISTER.ACCOUNT_CREATION_LABEL.FAILED'),
          dialogType: DialogType.failure,
        )
      );
    }
  }

  _resetErrorTexts() {
    emailErrorText = null;
    passwordErrorText = null;
    confirmPasswordErrorText = null;
    firstNameErrorText = null;
    lastNameErrorText = null;
    companyNameErrorText = null;
  }

  bool _validatePasswords(String password, String confirmPassword) {

    if(password.length < 8 || password.length > 16) {
      setState(() {
        passwordErrorText = AppLocalizations.of(context)!.translate('SHARED.ERROR.PASSWORD.LENGTH_MESSAGE');
      });
      return false;
    }
    if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password)) {
      setState(() {
        passwordErrorText = AppLocalizations.of(context)!.translate('SHARED.ERROR.PASSWORD.VALID_MESSAGE');
      });
      return false;
    }
    if (password != confirmPassword) {
      setState(() {
        confirmPasswordErrorText = AppLocalizations.of(context)!.translate('SHARED.ERROR.CONFIRM_PASSWORD_MESSAGE');
      });
      return false;
    }

    return true;
  }

  bool validateFields(String email, String password, String confirmPassword,
      String firstName, String lastName, String companyName) {
    _resetErrorTexts();
    bool areThereErrors = false;

    if(email == "") {
      setState(() {
        emailErrorText = AppLocalizations.of(context)!.translate('SHARED.ERROR.EMPTY_FIELD_MESSAGE');
      });
      areThereErrors = true;
    } else if(!email.contains('@')) {
      setState(() {
        emailErrorText = AppLocalizations.of(context)!.translate('SHARED.ERROR.EMAIL_MESSAGE');
      });
      areThereErrors = true;
    } else if(!email.contains('.', email.indexOf('@'))) {
      setState(() {
        emailErrorText = AppLocalizations.of(context)!.translate('SHARED.ERROR.EMAIL_MESSAGE');
      });
      areThereErrors = true;
    } else if(email.lastIndexOf('.') == email.length - 1) {
      setState(() {
        emailErrorText = AppLocalizations.of(context)!.translate('SHARED.ERROR.EMAIL_MESSAGE');
      });
      areThereErrors = true;
    }

    if(!_validatePasswords(password, confirmPassword)) {
      areThereErrors = true;
    }

    if (_accountType == 1) {
      if (companyName == "") {
        setState(() {
          companyNameErrorText = AppLocalizations.of(context)!.translate('SHARED.ERROR.EMPTY_FIELD_MESSAGE');
        });
        areThereErrors = true;
      }
    } else if (_accountType == 0) {
      if (firstName == "") {
        setState(() {
          firstNameErrorText = AppLocalizations.of(context)!.translate(
              'SHARED.ERROR.EMPTY_FIELD_MESSAGE');
        });
        areThereErrors = true;
      }
      if (lastName == "") {
        setState(() {
          lastNameErrorText = AppLocalizations.of(context)!.translate('SHARED.ERROR.EMPTY_FIELD_MESSAGE');
        });
        areThereErrors = true;
      }
    } else {
      areThereErrors = true;
    }

    return !areThereErrors;
  }
}