import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/auth/register/data/model/register_request.dart';
import 'package:exam/feature/auth/register/domain/model/user_model.dart';
import 'package:exam/feature/auth/register/domain/useCases/register_usecase.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_intent.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterState());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void doIntent(RegisterIntent intent) {
    switch (intent) {
      case DoRegisterIntent():
        _register(intent);
      case CheckFormFilledIntent():
        emit(state.copyWith(isFormFilled: intent.isFilled));
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

    if (result is SuccessResponse<RegisterModel>) {
      emit(state.copyWith(registerState: BaseState(isLoading: false, data: result.data)));
    } else {
      final error = (result as ErrorResponse).errorMessage;
      emit(
        state.copyWith(registerState: BaseState(isLoading: false, errorMessage: error.toString())),
      );
    }
  }

  void clearControllers() {
    firstNameController.clear();
    lastNameController.clear();
    usernameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
