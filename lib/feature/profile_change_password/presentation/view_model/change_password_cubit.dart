import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/profile_change_password/domain/usecase/change_password_use_case.dart';
import 'package:exam/feature/profile_change_password/presentation/view_model/change_password_intent.dart';
import 'package:exam/feature/profile_change_password/presentation/view_model/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordCubit extends Bloc<ChangePasswordIntent, ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(this._changePasswordUseCase)
      : super(const ChangePasswordState()) {
    on<ChangePasswordIntent>(_onIntent);
  }

  Future<void> _onIntent(
    ChangePasswordIntent intent,
    Emitter<ChangePasswordState> emit,
  ) async {
    switch (intent) {
      case ChangePasswordButtonPressed():
        await _changePassword(emit, intent);
        break;
    }
  }

  Future<void> _changePassword(
    Emitter<ChangePasswordState> emit,
    ChangePasswordButtonPressed intent,
  ) async {
    emit(state.copyWith(changePasswordState: BaseState(isLoading: true)));

    final result = await _changePasswordUseCase(
      oldPassword: intent.oldPassword,
      password: intent.password,
      rePassword: intent.rePassword,
    );

    switch (result) {
      case SuccessResponse():
        emit(state.copyWith(changePasswordState: BaseState(data: result.data)));
        break;
      case ErrorResponse():
        emit(
          state.copyWith(
            changePasswordState: BaseState(errorMessage: result.errorMessage),
          ),
        );
        break;
    }
  }
}
