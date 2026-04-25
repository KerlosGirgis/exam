import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/auth/register/data/model/register_request.dart';
import 'package:exam/feature/auth/register/domain/useCases/register_use_case.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_intent.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(const RegisterState());

  void doIntent(RegisterIntent intent) {
    switch (intent) {
      case DoRegisterIntent():
        _register(intent);
        break;
    }
  }

  Future<void> _register(DoRegisterIntent intent) async {
    emit(state.copyWith(registerState: BaseState(isLoading: true)));

    final request = RegisterRequest(
      firstName: intent.firstName,
      lastName: intent.lastName,
      username: intent.username,
      email: intent.email,
      phone: intent.phone,
      password: intent.password,
      rePassword: intent.confirmPassword,
    );

    final result = await registerUseCase(request);

    switch (result) {
      case SuccessResponse():
        emit(state.copyWith(registerState: BaseState(data: result.data)));
      case ErrorResponse():
        emit(
          state.copyWith(
            registerState: BaseState(errorMessage: result.errorMessage),
          ),
        );
    }
  }
}
