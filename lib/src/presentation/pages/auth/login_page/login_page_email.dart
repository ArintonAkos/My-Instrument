import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_instrument/src/business_logic/blocs/login_page/login_page_bloc.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:my_instrument/src/presentation/widgets/auth_pages_widgets.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/structure/route/router.gr.dart';
import 'package:provider/provider.dart';

class LoginPageEmail extends StatefulWidget {
  const LoginPageEmail({
    Key? key
  }) : super(key: key);

  @override
  _LoginPageEmailState createState() => _LoginPageEmailState();
}

class _LoginPageEmailState extends State<LoginPageEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

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
        validator: (email) {
          if (email == null || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
            return AppLocalizations.of(context)!.translate('SHARED.ERROR.EMAIL_MESSAGE');
          }

          return null;
        }
    );
  }

  Widget _buildPasswordTF() {
    return buildTF(
      AppLocalizations.of(context)!.translate('LOGIN.PASSWORD_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('LOGIN.PASSWORD_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      Icons.lock_outline,
      inputController: controllerPassword,
      obscureText: true,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(const ForgotPasswordRoute());
      },
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          AppLocalizations.of(context)!.translate('LOGIN.FORGOT_PASSWORD_LABEL'),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget getSubmitButtonChild(BuildContext context, LoginPageState state) {
    if (state.isLoading) {
      return const SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        )
      );
    }

    return Text(
      AppLocalizations.of(context)!.translate('LOGIN.BUTTON')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        SvgPicture.asset(
          'assets/auth/login.svg',
          height: 350,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            AppLocalizations.of(context)!.translate('LOGIN.BUTTON'),
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            )
          ),
        ),
        const SizedBox(height: 15,),
        Form(
          key: _formKey,
          child: Column(
            children: [
              _buildEmailTF(),
              const SizedBox(height: 15,),
              _buildPasswordTF(),
            ],
          ),
        ),
        const SizedBox(height: 25),
        _buildForgotPasswordBtn(),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginPageBloc>().add(
                  LoginUserWithEmail(
                    email: controllerEmail.text,
                    password: controllerPassword.text
                  )
                );
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
            child: BlocBuilder<LoginPageBloc, LoginPageState>(
              builder: (context, state) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: getSubmitButtonChild(context, state),
              ),
            )
          ),
        ),
      ],
    );
  }
}
