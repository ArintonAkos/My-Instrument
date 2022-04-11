part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

class SendResetPasswordEvent extends ResetPasswordEvent {
  final String email;
  final String token;
  final String password;

  const SendResetPasswordEvent({
    required this.email,
    required this.token,
    required this.password
  });

  @override
  List<Object?> get props => [ email, token, password ];
}
