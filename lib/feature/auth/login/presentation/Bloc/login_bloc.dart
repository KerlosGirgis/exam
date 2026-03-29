import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginState.initial()) {
    on<LoginSubmitted>(_login);
  }

  Future<void> _login(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoadingParam: true, errorMessageParam: null));

    final result = await loginUseCase(
      event.email,
      event.password,
      rememberMe: event.rememberMe,
    );

    switch (result) {
      case SuccessResponse(data: var data):
        emit(state.copyWith(
          isLoadingParam: false,
          dataParam: data,
        ));
      case ErrorResponse(errorMessage: var message):
        emit(state.copyWith(
          isLoadingParam: false,
          errorMessageParam: message,
        ));
    }
  }
}
