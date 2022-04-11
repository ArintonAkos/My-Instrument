part of 'login_page_bloc.dart';

abstract class LoginPageEvent extends Equatable {
  const LoginPageEvent();
}

class LoadingEvent extends LoginPageEvent {
  @override
  List<Object?> get props => [];
}

class LoginUserWithEmail extends LoginPageEvent {
  final String email;
  final String password;

  const LoginUserWithEmail({
    required this.email,
    required this.password
  });

  @override
  List<Object> get props => [ email, password ];
}

class LoginUserWithExternal extends LoginPageEvent {
  final ExternalLoginType loginType;

  const LoginUserWithExternal({
    required this.loginType
  });

  @override
  List<Object> get props => [ loginType ];
}