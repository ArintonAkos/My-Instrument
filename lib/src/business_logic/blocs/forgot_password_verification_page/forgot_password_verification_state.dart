part of 'forgot_password_verification_bloc.dart';

enum ForgotPasswordVerificationStatus { initial, loading, successful, failure, wrongCode }

extension ForgotPasswordVerificationStateX on ForgotPasswordVerificationState {
  bool get isLoading => (status == ForgotPasswordVerificationStatus.loading);
  bool get isSuccess => (status == ForgotPasswordVerificationStatus.successful);
  bool get isWrongCode => (status == ForgotPasswordVerificationStatus.wrongCode);
  bool get isFailure => (status == ForgotPasswordVerificationStatus.failure);
}

class ForgotPasswordVerificationState extends Equatable {
  final ForgotPasswordVerificationStatus status;
  final ValidatePin? response;
  final int? remainingTries;
  final String? errorMessage;

  const ForgotPasswordVerificationState({
    required this.status,
    required this.response,
    this.remainingTries,
    this.errorMessage
  });

  ForgotPasswordVerificationState copyWith({
    ForgotPasswordVerificationStatus? status,
    ValidatePin? response,
    int? remainingTries,
    String? errorMessage
  }) {
    return ForgotPasswordVerificationState(
      status: status ?? this.status,
      response: response ?? this.response,
      remainingTries: remainingTries ?? this.remainingTries,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  factory ForgotPasswordVerificationState.initial() {
    return const ForgotPasswordVerificationState(
      status: ForgotPasswordVerificationStatus.initial,
      response: null,
      remainingTries: 3,
      errorMessage: null
    );
  }

  @override
  List<Object?> get props => [ status, response, remainingTries, errorMessage ];
}
