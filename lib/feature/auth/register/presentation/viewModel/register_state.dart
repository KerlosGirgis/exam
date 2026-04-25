import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/auth/register/domain/model/register_details.dart';

class RegisterState {
  final BaseState<RegisterDetails>? registerState;

  const RegisterState({this.registerState});

  RegisterState copyWith({BaseState<RegisterDetails>? registerState}) {
    return RegisterState(
      registerState: registerState ?? this.registerState,
    );
  }
}
