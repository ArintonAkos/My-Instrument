import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_instrument/src/business_logic/blocs/login_page/login_page_bloc.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/auth_model.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/structure/route/router.gr.dart';

class LoginPageExternal extends StatelessWidget {
  const LoginPageExternal({
    Key? key
  }) : super(key: key);

  _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 30, 5, 20),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'OR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 16
              )
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildSocial(BuildContext context, String text, Widget icon, { VoidCallback? onTap }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
              left: 20,
              right: 20
            ),
            textStyle: const TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.bold
            ),
            onPrimary: Colors.grey,
            primary: Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          children: [
            icon,
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Visibility(
              visible: false,
              child: icon
            )
          ],
        )
      )
    );
  }

  _buildRegisterButton(BuildContext context, String label, String boldText, { required VoidCallback onTap }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have account?",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                fontSize: 16
              ),
            ),
            const SizedBox(width: 5,),
            Text(
              'Register',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16
              )
            )
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSeparator(),      // ignore: prefer_const_constructors
        _buildSocial(
          context,
          'Log in with Google',
          SvgPicture.asset(
            'assets/auth/google-logo.svg',
            height: 25,
          ),
          onTap: () {
            context.read<LoginPageBloc>().add(const LoginUserWithExternal(
              loginType: ExternalLoginType.google
            ));
          }
        ),
        _buildSocial(
          context,
          'Log in with Facebook',
          SvgPicture.asset(
            'assets/auth/facebook-logo.svg',
            height: 25,
          ),
          onTap: () {
            context.read<LoginPageBloc>().add(const LoginUserWithExternal(
              loginType: ExternalLoginType.google
            ));
          }
        ),
        const SizedBox(height: 30,),
        _buildRegisterButton(
          context,
          AppLocalizations.of(context)!.translate('LOGIN.REGISTER.LABEL'),
          AppLocalizations.of(context)!.translate('LOGIN.REGISTER.BOLD_TEXT'),
          onTap: () {
            AutoRouter.of(context).push(RegisterRoute());
          }
        ),
        const SizedBox(height:  30,),
      ],
    );
  }
}
