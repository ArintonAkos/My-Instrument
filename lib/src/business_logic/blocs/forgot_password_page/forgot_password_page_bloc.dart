import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/data/models/requests/auth/send_forgot_password_email_request.dart';
import 'package:my_instrument/src/data/repositories/manage_user_repository.dart';
import 'package:my_instrument/src/shared/utils/error_methods.dart';

part 'forgot_password_page_event.dart';
part 'forgot_password_page_state.dart';

class ForgotPasswordPageBloc extends Bloc<ForgotPasswordPageEvent, ForgotPasswordPageState> {
  ManageUserRepository manageUserRepository;

  ForgotPasswordPageBloc({
    required this.manageUserRepository
  }) : super(ForgotPasswordPageState.initial()) {
    on<ForgotPasswordPageEvent>((event, emit) async {
      if (event is SendEmailEvent) {
        try {
          emit(state.copyWith(status: ForgotPasswordPageStatus.loading, emailAddress: event.emailAddress));

          var resetPasswordId = await manageUserRepository.sendForgotPasswordEmail(SendForgotPasswordEmailRequest(
            email: event.emailAddress
          ));

          emit(state.copyWith(status: ForgotPasswordPageStatus.success, resetPasswordId: resetPasswordId));
        } on Exception catch (e) {

          emit(state.copyWith(
            status: ForgotPasswordPageStatus.failure,
            resetPasswordId: null,
            emailAddress: null,
            errorMessage: getErrorMessage(e)
          ));
        }
      }
    });
  }
}
