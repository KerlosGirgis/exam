import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/profile_change_password/data/model/change_password_response.dart';

class ChangePasswordState {
  final BaseState<ChangePasswordModel>? changePasswordState;

  ChangePasswordState({this.changePasswordState});

  ChangePasswordState copyWith({
    BaseState<ChangePasswordModel>? changePasswordState,
  }) {
    return ChangePasswordState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
    );
  }
}
