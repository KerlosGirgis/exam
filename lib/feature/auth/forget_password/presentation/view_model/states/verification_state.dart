import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/auth/forget_password/data/models/verify_reset_code_dto.dart';

class VerificationState {
  final BaseState<VerifyResetCodeDto> verifyCodeState;
 
  final bool isLoading;
  final bool isSuccess;
  final bool hasError;
  final String? errorMessage;

  VerificationState({
    BaseState<VerifyResetCodeDto>? verifyCodeState,
    this.isLoading = false,
    this.isSuccess = false,
    this.hasError = false,
    this.errorMessage,
  }) : verifyCodeState = verifyCodeState ?? BaseState<VerifyResetCodeDto>(isLoading: false);

  VerificationState copyWith({
    BaseState<VerifyResetCodeDto>? verifyCodeStateParam,
    bool? isLoadingParam,
    bool? isSuccessParam,
    bool? hasErrorParam,
    String? errorMessageParam,
  }) {
    return VerificationState(
      verifyCodeState: verifyCodeStateParam ?? verifyCodeState,
      isLoading: isLoadingParam ?? isLoading,
      isSuccess: isSuccessParam ?? isSuccess,
      hasError: hasErrorParam ?? hasError,
      errorMessage: errorMessageParam ?? errorMessage,
    );
  }
}