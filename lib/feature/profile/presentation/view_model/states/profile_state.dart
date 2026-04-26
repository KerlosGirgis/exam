

import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/profile/domain/models/user_data_model.dart';

const _sentinel = Object();

class ProfileState {
  final BaseState<UserDataModel> profileState;
  final bool isLoading1;
  final bool isUpdating;
  final UserDataModel? profile;
  final String? errorMessage1;
  final String? updateErrorMessage;
  final bool updateSuccess;
  final bool hasChanges;
  final bool isLoggingOut;
  final bool logoutSuccess;

  ProfileState({
    BaseState<UserDataModel>? profileState,
    this.isLoading1 = false,
    this.isUpdating = false,
    this.profile,
    this.errorMessage1,
    this.updateErrorMessage,
    this.updateSuccess = false,
    this.hasChanges = false,
    this.isLoggingOut = false,
    this.logoutSuccess = false,
  }) : profileState =
           profileState ??
           BaseState<UserDataModel>(isLoading: false);

  ProfileState copyWith({
    BaseState<UserDataModel>? profileStateParam,
    bool? isLoadingParam,
    bool? isUpdatingParam,
    Object? dataParam = _sentinel,
    Object? errorMessageParam = _sentinel,
    Object? updateErrorMessageParam = _sentinel,
    bool? updateSuccessParam,
    bool? hasChangesParam,
    bool? isLoggingOutParam,
    bool? logoutSuccessParam,
  }) {
    return ProfileState(
      profileState: profileStateParam ?? profileState,
      isLoading1: isLoadingParam ?? isLoading1,
      isUpdating: isUpdatingParam ?? isUpdating,
      profile: identical(dataParam, _sentinel)
          ? profile
          : dataParam as UserDataModel?,
      errorMessage1: identical(errorMessageParam, _sentinel)
          ? errorMessage1
          : errorMessageParam as String?,
      updateErrorMessage: identical(updateErrorMessageParam, _sentinel)
          ? updateErrorMessage
          : updateErrorMessageParam as String?,
      updateSuccess: updateSuccessParam ?? updateSuccess,
      hasChanges: hasChangesParam ?? hasChanges,
      isLoggingOut: isLoggingOutParam ?? isLoggingOut,
      logoutSuccess: logoutSuccessParam ?? logoutSuccess,
    );
  }
}
