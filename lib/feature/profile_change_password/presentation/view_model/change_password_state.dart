import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/profile_change_password/domain/model/change_password_details.dart';

class ChangePasswordState {
  final BaseState<ChangePasswordDetails>? changePasswordState;

  const ChangePasswordState({this.changePasswordState});

  ChangePasswordState copyWith({
    BaseState<ChangePasswordDetails>? changePasswordState,
  }) {
    return ChangePasswordState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
    );
  }
}
