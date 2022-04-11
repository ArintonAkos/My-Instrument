import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/auth_model.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  final AuthModel authModel;

  LoginPageBloc({
    required this.authModel
  }) : super(LoginPageState.initial()) {
    on<LoginPageEvent>((event, emit) async {
      try {
        if (!state.isLoading) {
          emit(state.copyWith(status: LoginPageStatus.loading));

          if (event is LoginUserWithEmail) {
            var res = await authModel.signIn(event.email, event.password);

            if (res.success) {
              emit(state.copyWith(status: LoginPageStatus.success));
            } else {
              emit(state.copyWith(
                status: LoginPageStatus.failure,
                errorMessage: res.exception?.toString().replaceFirst(RegExp(r"[^]*(: |:)"), "")
              ));
            }
          } else if (event is LoginUserWithExternal) {
            var res = await authModel.externalLogin(event.loginType);

            if (!res.success) {
              emit(state.copyWith(status: LoginPageStatus.success));
            } else {
              emit(state.copyWith(status: LoginPageStatus.failure, errorMessage: (res.exception as String?)));
            }
          }
        }
      } catch (e) {
        emit(state.copyWith(status: LoginPageStatus.failure, errorMessage: null));
      }
    });
  }
}
