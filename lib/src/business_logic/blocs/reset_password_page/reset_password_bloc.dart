import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/data/models/requests/auth/change_password_request.dart';
import 'package:my_instrument/src/data/repositories/manage_user_repository.dart';
import 'package:my_instrument/src/shared/utils/error_methods.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ManageUserRepository manageUserRepository;

  ResetPasswordBloc({
    required this.manageUserRepository
  }) : super(ResetPasswordState.initial()) {
    on<ResetPasswordEvent>((event, emit) async {
      if (event is SendResetPasswordEvent) {
        try {
          emit(state.copyWith(status: ResetPasswordStatus.loading));

          await manageUserRepository.changePassword(ChangePasswordRequest(
            email: event.email,
            token: event.token,
            newPassword: event.password
          ));

          emit(state.copyWith(status: ResetPasswordStatus.success));
        } on Exception catch(e) {
          emit(state.copyWith(
            status: ResetPasswordStatus.failure,
            errorMessage: getErrorMessage(e)
          ));
        }
      }
    });
  }
}
