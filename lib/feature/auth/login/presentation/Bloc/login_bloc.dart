import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginSubmitted>(_login);
  }

  Future<void> _login(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {

    emit(LoginLoading());

    try {
      await loginUseCase(
        event.email,
        event.password,
      );
      emit(LoginSuccess());

    } catch (e) {
      emit(LoginFailure("Login failed"));
    }
  }
}