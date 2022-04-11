part of 'forgot_password_page_bloc.dart';

abstract class ForgotPasswordPageEvent extends Equatable {
  const ForgotPasswordPageEvent();
}

class SendEmailEvent extends ForgotPasswordPageEvent {
  final String emailAddress;

  const SendEmailEvent({
    required this.emailAddress
  });

  @override
  List<Object> get props => [ emailAddress ];
}
