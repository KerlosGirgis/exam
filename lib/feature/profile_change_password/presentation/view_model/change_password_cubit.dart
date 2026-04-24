import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/profile_change_password/domain/usecase/change_password_usecase.dart';
import 'package:exam/feature/profile_change_password/presentation/view_model/change_password_intent.dart';
import 'package:exam/feature/profile_change_password/presentation/view_model/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordCubit extends Bloc<ChangePasswordIntent, ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  ChangePasswordCubit(this._changePasswordUseCase)
      : super(ChangePasswordState()) {
    on<ChangePasswordIntent>(_onIntent);
  }

  Future<void> _onIntent(
    ChangePasswordIntent intent,
    Emitter<ChangePasswordState> emit,
  ) async {
    switch (intent.runtimeType) {
      case ChangePasswordButtonPressed:
        final i = intent as ChangePasswordButtonPressed;
        await _changePassword(
          emit: emit,
          token: i.token,
          oldPassword: i.oldPassword,
          password: i.password,
          rePassword: i.rePassword,
        );
        break;
    }
  }

  Future<void> _changePassword({
    required Emitter<ChangePasswordState> emit,
    required String token,
    required String oldPassword,
    required String password,
    required String rePassword,
  }) async {
    emit(state.copyWith(changePasswordState: BaseState(isLoading: true)));

    final result = await _changePasswordUseCase(
      token: token,
      oldPassword: oldPassword,
      password: password,
      rePassword: rePassword,
    );

    switch (result) {
      case SuccessResponse():
        emit(
          state.copyWith(
            changePasswordState: BaseState(data: result.data),
          ),
        );
      case ErrorResponse():
        emit(
          state.copyWith(
            changePasswordState: BaseState(errorMessage: result.errorMessage),
          ),
        );
        break;
    }
  }

  void clearControllers() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
