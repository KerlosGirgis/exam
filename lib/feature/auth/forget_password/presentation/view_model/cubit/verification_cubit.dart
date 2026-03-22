import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/auth/forget_password/domain/models/verify_reset_code_model.dart';
import 'package:exam/feature/auth/forget_password/domain/use_case/verify_reset_code_use_case.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/states/verification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

@injectable
class VerificationCubit extends Cubit<VerificationState> {
  final VerifyResetCodeUseCase _useCase;

  VerificationCubit(this._useCase) : super(VerificationState());
  final pinController = PinInputController();
  Future<void> verifyCode(String code) async {
    emit(state.copyWith(isLoadingParam: true, hasErrorParam: false));

    final response = await _useCase(resetCode: code);

    switch (response) {
      case SuccessResponse<VerifyResetCodeModel>():
        emit(
          state.copyWith(
            isLoadingParam: false,
            isSuccessParam: true,
            verifyCodeStateParam: BaseState(isLoading: false),
          ),
        );
        break;
      case ErrorResponse<VerifyResetCodeModel>():
        emit(
          state.copyWith(
            isLoadingParam: false,
            hasErrorParam: true,
            errorMessageParam: response.errorMessage,
            verifyCodeStateParam: BaseState(
              errorMessage: response.errorMessage,
              isLoading: false,
            ),
          ),
        );
        break;
    }
  }

  void resetError() {
    emit(state.copyWith(hasErrorParam: false, errorMessageParam: null));
  }

  @override
  Future<void> close() {
    pinController.dispose();
    return super.close();
  }
}
