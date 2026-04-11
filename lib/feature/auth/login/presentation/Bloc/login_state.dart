import '../../../../../config/base_state/base_state.dart';
import '../../domain/entities/user_entity.dart';

class LoginState extends BaseState<(User, String)> {
  LoginState({
    super.isLoading,
    super.errorMessage,
    super.data,
  });

  factory LoginState.initial() => LoginState();

  @override
  LoginState copyWith({
    bool? isLoadingParam,
    String? errorMessageParam,
    (User, String)? dataParam,
  }) {
    return LoginState(
      isLoading: isLoadingParam ?? isLoading,
      errorMessage: errorMessageParam ?? errorMessage,
      data: dataParam ?? data,
    );
  }
}
