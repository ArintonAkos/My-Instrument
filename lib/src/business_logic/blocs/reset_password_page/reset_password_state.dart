part of 'reset_password_bloc.dart';

enum ResetPasswordStatus {
  initial,
  loading,
  success,
  failure
}

extension ResetPasswordStateX on ResetPasswordState {
  bool get isInitial => (status == ResetPasswordStatus.initial);
  bool get isLoading => (status == ResetPasswordStatus.loading);
  bool get isSuccess => (status == ResetPasswordStatus.success);
  bool get isFailure => (status == ResetPasswordStatus.failure);
}

class ResetPasswordState extends Equatable {
  final ResetPasswordStatus status;
  final String? errorMessage;

  const ResetPasswordState({
    required this.status,
    this.errorMessage
  });

  factory ResetPasswordState.initial() {
    return const ResetPasswordState(
      status: ResetPasswordStatus.initial,
    );
  }

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    String? errorMessage
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [ status, errorMessage ];
}