part of 'forgot_password_verification_bloc.dart';

abstract class ForgotPasswordVerificationEvent extends Equatable {
  const ForgotPasswordVerificationEvent();
}

class VerifyPin extends ForgotPasswordVerificationEvent {
  final String pin;
  final String resetPasswordId;

  const VerifyPin({
    required this.pin,
    required this.resetPasswordId
  });

  @override
  List<Object> get props => [ pin, resetPasswordId ];
}