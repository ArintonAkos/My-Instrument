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

  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = false;
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

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.translate('LOGIN.EMAIL_INPUT_LABEL'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle(Provider.of<ThemeNotifier>(context).getTheme()),
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: controllerEmail,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              fillColor: Colors.red,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: AppLocalizations.of(context)!.translate('LOGIN.EMAIL_INPUT_TEXT'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.translate('LOGIN.PASSWORD_INPUT_LABEL'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle(Provider.of<ThemeNotifier>(context).getTheme()),
          height: 60.0,
          child: TextField(
            obscureText: true,
            controller: controllerPassword,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: AppLocalizations.of(context)!.translate('LOGIN.PASSWORD_INPUT_TEXT'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.LoginButtonsColor,
          onPrimary: Colors.grey[400]
        ),
        onPressed: _isButtonDisabled ? null : _loginUser,
        child: Text(
          AppLocalizations.of(context)!.translate('LOGIN.LOGIN_BUTTON'),
          style: TextStyle(
            color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.LoginButtonText,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
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
    return GestureDetector(
      onTap: () => _register,
      child: RichText(
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
              text: AppLocalizations.of(context)!.translate('LOGIN.REGISTER_BOLD_TEXT'),
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
                    vertical: 60.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: Icon(
                            _getThemeIcon(Provider.of<ThemeNotifier>(context)),
                            color: Colors.white,
                            size: 30,
                          ),
                          onTap: () {
                            _onThemeClick(Provider.of<ThemeNotifier>(context, listen: false));
                          },
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.translate('LOGIN.LOGIN_HEADER_TEXT'),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
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

  _register() {
  }

  _loginUser() async {
    _disableButton();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    AuthModel authModel = Modular.get<AuthModel>();;

    var response = await authModel.signIn(email, password);

    _enableButton();
    if (!response.success) {
      showDialog(context: context,
          builder: (BuildContext dialogContext) => CustomDialog(
            description: 'An error occurred, please try again later!',
            dialogType: DialogType.Failure,
          )
      );
    } else {
      Modular.to.pushNamed('/home/');
    }
  }

  IconData _getThemeIcon(ThemeNotifier themeNotifier) {
    switch (themeNotifier.getThemeName()) {
      case 'dark':
        return Icons.dark_mode;
      default:
        return Icons.light_mode;
    }
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
}