import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/auth/forget_password/domain/models/reset_password_model.dart';
import 'package:exam/feature/auth/forget_password/domain/use_case/reset_password_use_case.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/states/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _useCase;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = false;
  void changeObscureText() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  ResetPasswordCubit(this._useCase) : super(ResetPasswordState());

  Future<void> resetPassword(String email, String newPassword) async {
    if (!formKey.currentState!.validate()) return;
    if (passwordController.text != confirmPasswordController.text) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Passwords do not match",
          isSuccess: false,
        ),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final response = await _useCase(email: email, newPassword: newPassword);

    switch (response) {
      case SuccessResponse<ResetPasswordModel>():
        emit(state.copyWith(isLoading: false, isSuccess: true));
        break;
      case ErrorResponse<ResetPasswordModel>():
        emit(
          state.copyWith(isLoading: false, errorMessage: response.errorMessage),
        );
        break;
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
