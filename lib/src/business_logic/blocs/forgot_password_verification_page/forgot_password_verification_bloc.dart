import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/data/models/requests/auth/validate_pin_request.dart';
import 'package:my_instrument/src/data/repositories/manage_user_repository.dart';
import 'package:my_instrument/src/shared/utils/error_methods.dart';

part 'forgot_password_verification_event.dart';
part 'forgot_password_verification_state.dart';

class ForgotPasswordVerificationBloc extends Bloc<ForgotPasswordVerificationEvent, ForgotPasswordVerificationState> {
  ManageUserRepository manageUserRepository;

  ForgotPasswordVerificationBloc({
    required this.manageUserRepository
  }) : super(ForgotPasswordVerificationState.initial()) {
    on<ForgotPasswordVerificationEvent>((event, emit) async {
      if (event is VerifyPin) {
        try {
          emit(state.copyWith(status: ForgotPasswordVerificationStatus.loading));

          var res = await manageUserRepository.validatePin(ValidatePinRequest(
            resetPasswordId: event.resetPasswordId,
            pin: event.pin
          ));

          if (!res.ok) {
            emit(state.copyWith(
              status: ForgotPasswordVerificationStatus.wrongCode,
              remainingTries: res.remainingTries
            ));
          } else {
            emit(state.copyWith(status: ForgotPasswordVerificationStatus.successful, response: res));
          }
        } on Exception catch (e) {
          emit(state.copyWith(
            status: ForgotPasswordVerificationStatus.failure,
            errorMessage: getErrorMessage(e)
          ));
        }
      }
    });
  }
}
