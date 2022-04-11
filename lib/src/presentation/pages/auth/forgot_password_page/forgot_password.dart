import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/business_logic/blocs/forgot_password_page/forgot_password_page_bloc.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:my_instrument/src/data/repositories/manage_user_repository.dart';
import 'package:my_instrument/src/presentation/widgets/auth_pages_widgets.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/structure/route/router.gr.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_toast/custom_toast.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Widget _buildEmailTF(BuildContext context) {
    return buildTF(
      AppLocalizations.of(context)!.translate('LOGIN.EMAIL_INPUT.LABEL'),
      AppLocalizations.of(context)!.translate('LOGIN.EMAIL_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      Icons.email_outlined,
      inputController: _emailController,
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

  Widget getButtonChild(BuildContext context, ForgotPasswordPageState state) {
    if (state.isSuccess) {
      return const Icon(
          LineIcons.check,
          size: 18,
          color: Colors.white
      );
    }

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
  Widget build(BuildContext context) {
    final bool showSubmitButton = (MediaQuery.of(context).viewInsets.bottom == 0.0);

    return BlocProvider(
      create: (context) => ForgotPasswordPageBloc(
        manageUserRepository: RepositoryProvider.of<ManageUserRepository>(context)
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
                          'assets/auth/forgot_password.svg',
                          height: 350,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            AppLocalizations.of(context)!.translate('LOGIN.FORGOT_PASSWORD_LABEL'),
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            AppLocalizations.of(context)!.translate('FORGOT_PASSWORD.SUB_TITLE'),
                            style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Form(
                          key: _formKey,
                          child: _buildEmailTF(context),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: BlocListener<ForgotPasswordPageBloc, ForgotPasswordPageState>(
                      listener: (context, state) {
                        if (state.isSuccess) {
                          showCustomToast(ToastType.success, AppLocalizations.of(context)!.translate('FORGOT_PASSWORD.SUCCESS_MESSAGE'));
                          AutoRouter.of(context).replace(ForgotPasswordVerificationRoute(
                            email: state.emailAddress!,
                            resetPasswordId: state.resetPasswordId!
                          ));
                        } else if (state.isFailure) {
                          showCustomToast(ToastType.error, state.errorMessage!);
                        }
                      },
                      child: BlocBuilder<ForgotPasswordPageBloc, ForgotPasswordPageState>(
                        builder: (context, state) => Visibility(
                            visible: (showSubmitButton),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ForgotPasswordPageBloc>().add(
                                      SendEmailEvent(
                                        emailAddress: _emailController.text
                                      )
                                    );
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
                                child: getButtonChild(context, state),
                              ),
                            )
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
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          AutoRouter.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          size: 26,
                        ),
                        splashRadius: 27,
                      ),
                    ),
                  ),
                ),
              ]
            )
          )
        )
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}