part of 'login_page_bloc.dart';

enum LoginPageStatus { initial, loading, success, failure }

extension LoginPageStateX on LoginPageState {
  bool get isLoading => (status == LoginPageStatus.loading);
  bool get isSuccess => (status == LoginPageStatus.success);
  bool get isFailure => (status == LoginPageStatus.failure);
}

class LoginPageState extends Equatable {
  final LoginPageStatus status;
  final String? errorMessage;

  const LoginPageState({
    required this.status,
    this.errorMessage
  });

  LoginPageState copyWith({
    LoginPageStatus? status,
    String? errorMessage
  }) {
    return LoginPageState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  factory LoginPageState.initial() {
    return const LoginPageState(
      status: LoginPageStatus.initial
    );
  }

  @override
  String toString() {
    return '''LoginPageState {
      status: $status,
      errorMessage: $errorMessage
    }''';
  }

  @override
  List<Object?> get props => [ status, errorMessage ];
}