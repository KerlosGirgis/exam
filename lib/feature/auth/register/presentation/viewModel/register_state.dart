import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/auth/register/domain/model/user_model.dart';

class RegisterState {
  BaseState<RegisterModel>? registerState;

  bool isFormFilled;

  RegisterState({this.registerState, this.isFormFilled = false});

  RegisterState copyWith({
    BaseState<RegisterModel>? registerState,
    bool? isFormFilled,
  }) {
    return RegisterState(
      registerState: registerState ?? this.registerState,
      isFormFilled: isFormFilled ?? this.isFormFilled,
    );
  }
}
