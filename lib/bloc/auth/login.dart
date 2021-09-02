import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';
import 'package:my_instrument/shared/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

import 'auth_pages_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  })
    : super(key: key);


  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  bool _rememberMe = false;
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  late Icon _themeSwitcherIcon;

  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = false;
    _themeSwitcherIcon = _getThemeIcon(Provider.of<ThemeNotifier>(context, listen: false).getThemeName());
  }

  void _disableButton() {
    setState(() {
      _isButtonDisabled = true;
    });
  }

  void _enableButton() {
    setState(() {
      _isButtonDisabled = false;
    });
  }

  void _updateThemeIcon(String oldTheme) {
    Icon newIcon;
    switch (oldTheme) {
      case 'dark':
        newIcon = _getThemeIcon('');
        break;
      default:
        newIcon = _getThemeIcon('dark');
        break;
    }
    setState(() {
      _themeSwitcherIcon = newIcon;
    });
  }

  Widget _buildEmailTF() {
    return buildTF(
      AppLocalizations.of(context)!.translate('LOGIN.EMAIL_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('LOGIN.EMAIL_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      inputController: controllerEmail,
      textInputType: TextInputType.emailAddress
    );
  }

  Widget _buildPasswordTF() {
    return buildTF(
      AppLocalizations.of(context)!.translate('LOGIN.PASSWORD_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('LOGIN.PASSWORD_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      inputController: controllerPassword,
      obscureText: true
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(right: 0.0),
        ),
        onPressed: () => print('Forgot Password Button Pressed'),
        child: Text(
          AppLocalizations.of(context)!.translate('LOGIN.FORGOT_PASSWORD_LABEL'),
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Theme.of(context).colorScheme.primary,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            AppLocalizations.of(context)!.translate('LOGIN.REMEMBER_ME_LABEL'),
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return buildAuthButton(
      AppLocalizations.of(context)!.translate('LOGIN.BUTTON'),
      Provider.of<ThemeNotifier>(context).getTheme()?.customTheme,
      onPressed: _loginUser,
      disabled: _isButtonDisabled,
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.translate('LOGIN.OR_LABEL'),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          AppLocalizations.of(context)!.translate('LOGIN.SIGN_IN_WITH_LABEL'),
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(VoidCallback onTap, Icon logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.LoginButtonsColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: logo
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
                () => print('Login with Facebook'),
            Icon(
              FontAwesomeIcons.facebookF,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          _buildSocialBtn(
                () => print('Login with Google'),
            Icon(
              FontAwesomeIcons.google,
              color: Theme.of(context).colorScheme.primary
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppLocalizations.of(context)!.translate('LOGIN.REGISTER_LABEL'),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.translate('LOGIN.REGISTER.BOLD_TEXT'),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {
              Modular.to.pushNamed('/register');
            }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Text(
                                AppLocalizations.of(context)!.translate('LOGIN.HEADER_TEXT'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  transitionBuilder: (Widget child, Animation<double> animation) => 
                                    ScaleTransition(scale: animation, child: child,),
                                  child: _themeSwitcherIcon,
                                ),
                                onTap: () {
                                  _onThemeClick(Provider.of<ThemeNotifier>(context, listen: false));
                                },
                              ),
                            ),
                          ],
                        )
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      _buildLoginBtn(),
                      _buildSignInWithText(),
                      _buildSocialBtnRow(),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _loginUser() async {
    _disableButton();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    AuthModel authModel = Modular.get<AuthModel>();;

    var response = await authModel.signIn(email, password,
        rememberMe: _rememberMe);

    _enableButton();
    if (!response.success) {
      showDialog(context: context,
          builder: (BuildContext dialogContext) => CustomDialog(
            description: AppLocalizations.of(context)!.translate('SHARED.BASIC_ERROR_MESSAGE'),
            dialogType: DialogType.Failure,
          )
      );
    } else {
      Modular.to.navigate('/home/');
    }
  }

  IconData _getThemeIconData(String themeName) {
    switch (themeName) {
      case 'dark':
        return Icons.dark_mode;
      default:
        return Icons.light_mode;
    }
  }

  Icon _getThemeIcon(String themeName) {
    return Icon(
      _getThemeIconData(themeName),
      key: ValueKey<int>(themeName == 'dark' ? 1 : 0),
      color: Colors.white,
      size: 30,
    );
  }

  void _onThemeClick(ThemeNotifier themeNotifier) {
    String themeName = themeNotifier.getThemeName();
    _updateThemeIcon(themeName);
    switch (themeName) {
      case 'dark':
        themeNotifier.setLightMode();
        break;
      default:
        themeNotifier.setDarkMode();
        break;
    }

  }
}