import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/business_logic/blocs/forgot_password_verification_page/forgot_password_verification_bloc.dart';
import 'package:my_instrument/src/data/repositories/manage_user_repository.dart';
import 'package:my_instrument/src/presentation/widgets/custom_toast/custom_toast.dart';
import 'package:my_instrument/structure/route/router.gr.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../shared/translation/app_localizations.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  final String email;
  final String resetPasswordId;

  const ForgotPasswordVerificationPage({
    Key? key,
    required this.email,
    required this.resetPasswordId
  }) : super(key: key);

  @override
  _ForgotPasswordVerificationPageState createState() => _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState extends State<ForgotPasswordVerificationPage> {
  TextEditingController pinController = TextEditingController();
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  Widget getButtonChild(BuildContext context, ForgotPasswordVerificationState state) {
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
      create: (context) => ForgotPasswordVerificationBloc(
        manageUserRepository: RepositoryProvider.of<ManageUserRepository>(context)
      ),
      child: Scaffold(
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
                          'assets/auth/forgot-password-verification.svg',
                          height: 350
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            AppLocalizations.of(context)!.translate('FORGOT_PASSWORD_VERIFICATION.TITLE'),
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
                            AppLocalizations.of(context)!.translate('FORGOT_PASSWORD_VERIFICATION.HINT_TEXT'),
                            style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: PinCodeTextField(
                            scrollPadding: const EdgeInsets.only(bottom: 200),
                            length: 4,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldOuterPadding: EdgeInsets.zero,
                              inactiveFillColor: Theme.of(context).colorScheme.surface,
                              selectedFillColor: Theme.of(context).colorScheme.surface,
                              activeFillColor: Theme.of(context).colorScheme.surface,
                              inactiveColor: Theme.of(context).colorScheme.surface,
                              selectedColor: Theme.of(context).colorScheme.surface,
                              activeColor: Theme.of(context).colorScheme.surface,
                              borderWidth: 0,
                              fieldWidth: 40,
                              fieldHeight: 50
                            ),
                            errorAnimationController: errorController,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 5)
                              )
                            ],
                            enableActiveFill: true,
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                            ),
                            animationType: AnimationType.fade,
                            controller: pinController,
                            onCompleted: (v) {},
                            onChanged: (v) {},
                            cursorHeight: 19.5,
                            appContext: context,
                            autoDisposeControllers: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<ForgotPasswordVerificationBloc, ForgotPasswordVerificationState>(
                          builder: (context, state) {
                            if (state.isWrongCode) {
                              return Text(
                                AppLocalizations.of(context)!.translate('FORGOT_PASSWORD_VERIFICATION.ERROR_MESSAGE'),
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error
                                ),
                              );
                            }

                            return const SizedBox(height: 0,);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Visibility(
                    visible: (showSubmitButton),
                    child: BlocConsumer<ForgotPasswordVerificationBloc, ForgotPasswordVerificationState>(
                      listener: (context, state) {
                        if (state.isSuccess) {
                          if (state.response?.ok ?? false) {
                            AutoRouter.of(context).replace(ResetPasswordRoute(
                              resetPasswordToken: state.response!.token!,
                              email: widget.email
                            ));
                          }
                        } else if (state.isWrongCode || state.isFailure) {
                            if (state.remainingTries == 0 || state.remainingTries == null) {
                              AutoRouter.of(context).pop();
                            }

                            if (state.isFailure) {
                              showCustomToast(ToastType.error, state.errorMessage!);
                            }
                        }
                      },
                      builder: (context, state) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            if (pinController.text.length == 4) {
                              context.read<ForgotPasswordVerificationBloc>().add(
                                VerifyPin(
                                  pin: pinController.text,
                                  resetPasswordId: widget.resetPasswordId
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
      ),
    );
  }
}