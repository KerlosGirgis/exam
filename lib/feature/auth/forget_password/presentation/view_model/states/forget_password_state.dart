import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/auth/forget_password/domain/models/forget_password_model.dart';

class ForgetPasswordState {
  final BaseState<ForgetPasswordModel> forgetPasswordState;
  final bool isLoading1;
  final ForgetPasswordModel? forgetPassword;
  final String? errorMessage1;

  ForgetPasswordState({
    BaseState<ForgetPasswordModel>? forgetPasswordState,
    this.isLoading1 = false,
    this.forgetPassword,
    this.errorMessage1,
  }) : forgetPasswordState =
           forgetPasswordState ??
           BaseState<ForgetPasswordModel>(isLoading: false);

  ForgetPasswordState copyWith({
    BaseState<ForgetPasswordModel>? forgetPasswordStateParam,
    bool? isLoadingParam,
    ForgetPasswordModel? dataParam,
    String? errorMessageParam,
  }) {
    return ForgetPasswordState(
      forgetPasswordState: forgetPasswordStateParam ?? forgetPasswordState,
      isLoading1: isLoadingParam ?? isLoading1,
      forgetPassword: dataParam ?? forgetPassword,
      errorMessage1: errorMessageParam ?? errorMessage1,
    );
  }
}
