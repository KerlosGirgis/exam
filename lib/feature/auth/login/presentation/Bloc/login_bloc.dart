import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

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
      final result = await loginUseCase(
        event.email,
        event.password,
      );

      final user = result.$1;
      final token = result.$2;

      // save token later

      emit(LoginSuccess());

    } catch (e) {
      emit(LoginFailure("Login failed"));
    }
  }
}