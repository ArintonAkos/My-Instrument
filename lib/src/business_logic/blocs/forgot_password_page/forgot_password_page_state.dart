part of 'forgot_password_page_bloc.dart';

enum ForgotPasswordPageStatus {
  initial,
  loading,
  success,
  failure
}

extension ForgotPasswordPageStateX on ForgotPasswordPageState {
  bool get isLoading => (status == ForgotPasswordPageStatus.loading);
  bool get isSuccess => (status == ForgotPasswordPageStatus.success);
  bool get isFailure => (status == ForgotPasswordPageStatus.failure);
}

class ForgotPasswordPageState extends Equatable {
  final ForgotPasswordPageStatus status;
  final String? emailAddress;
  final String? resetPasswordId;
  final String? errorMessage;

  const ForgotPasswordPageState({
    required this.status,
    required this.emailAddress,
    required this.resetPasswordId,
    this.errorMessage
  });

  ForgotPasswordPageState copyWith({
    ForgotPasswordPageStatus? status,
    String? emailAddress,
    String? resetPasswordId,
    String? errorMessage,
  }) {
    return ForgotPasswordPageState(
      status: status ?? this.status,
      emailAddress: emailAddress ?? this.emailAddress,
      resetPasswordId: resetPasswordId ?? this.resetPasswordId,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  factory ForgotPasswordPageState.initial() {
    return const ForgotPasswordPageState(
      status: ForgotPasswordPageStatus.initial,
      emailAddress: null,
      resetPasswordId: null,
      errorMessage: null,
    );
  }

  @override
  String toString() {
    return ''' ForgotPasswordPageState {
      status: $status,
      emailAddress: $emailAddress,
      confirmEmailId: $resetPasswordId,
      errorMessage: $errorMessage
    }''';
  }

  @override
  List<Object?> get props => [ status, emailAddress, resetPasswordId, errorMessage ];
}