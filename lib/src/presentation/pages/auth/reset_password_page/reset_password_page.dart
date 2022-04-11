import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/business_logic/blocs/reset_password_page/reset_password_bloc.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:my_instrument/src/presentation/widgets/auth_pages_widgets.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_toast/custom_toast.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String resetPasswordToken;

  const ResetPasswordPage({
    Key? key,
    required this.email,
    required this.resetPasswordToken
  }) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Widget _buildPasswordTF(BuildContext context, String label, String hint, TextEditingController controller, FormFieldValidator<String> validator) {
    return buildTF(
      label,
      hint,
      Provider.of<ThemeNotifier>(context).getTheme(),
      LineIcons.lock,
      inputController: controller,
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
      validator: validator
    );
  }

  Widget buildPasswordTF(BuildContext context) {
    return _buildPasswordTF(
      context,
      AppLocalizations.of(context)!.translate('LOGIN.PASSWORD_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('LOGIN.PASSWORD_INPUT.HINT'),
      passwordController,
      (value) {
        if (value == null) {
          return AppLocalizations.of(context)!.translate('SHARED.ERROR.EMPTY_FIELD_MESSAGE');
        }

        if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
          return AppLocalizations.of(context)!.translate('SHARED.ERROR.PASSWORD.VALID_MESSAGE');
        }

        return null;
      }
    );
  }

  Widget buildConfirmPasswordTF(BuildContext context) {
    return _buildPasswordTF(
      context,
      AppLocalizations.of(context)!.translate('REGISTER.CONFIRM_PASSWORD_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('REGISTER.CONFIRM_PASSWORD_INPUT.HINT'),
      confirmPasswordController,
      (value) {
        if (value != passwordController.text) {
          return AppLocalizations.of(context)!.translate('SHARED.ERROR.CONFIRM_PASSWORD_MESSAGE');
        }

        return null;
      }
    );
  }

  Widget getButtonChild(BuildContext context, ResetPasswordState state) {
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
      AppLocalizations.of(context)!.translate('SHARED.INFO.SUBMIT')
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showSubmitButton = (MediaQuery.of(context).viewInsets.bottom == 0.0);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/auth/reset-password.svg',
                        height: 350
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          AppLocalizations.of(context)!.translate('RESET_PASSWORD.TITLE'),
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            buildPasswordTF(context),
                            const SizedBox(height: 10),
                            buildConfirmPasswordTF(context),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Visibility(
                  visible: (showSubmitButton),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                      listener: (context, state) {
                        if (state.isSuccess) {
                          showCustomToast(
                            ToastType.success,
                            AppLocalizations.of(context)!.translate('RESET_PASSWORD.SUCCESS_MESSAGE')
                          );
                          AutoRouter.of(context).pop(); /// Return to the Login Page.
                        } else if (state.isFailure) {
                          showCustomToast(ToastType.error, state.errorMessage!);
                        }
                      },
                      builder: (context, state) => ElevatedButton(
                        onPressed: () {
                          if (!state.isLoading) {
                            if (_formKey.currentState!.validate()) {
                              context.read<ResetPasswordBloc>().add(SendResetPasswordEvent(
                                email: widget.email,
                                token: widget.resetPasswordToken,
                                password: passwordController.text
                              ));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.bold
                            ),
                            shadowColor: Theme.of(context).colorScheme.primary
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 1000),
                          child: getButtonChild(context, state),
                        )
                      ),
                    ),
                  )
                ),
              ),
              Positioned(
                top: 5,
                left: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: IconButton(
                      onPressed: () => AutoRouter.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 26,
                      ),
                      splashRadius: 27,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}