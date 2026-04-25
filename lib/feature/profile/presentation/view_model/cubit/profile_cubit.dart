import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/profile/data/models/request/edit_profile_request.dart';
import 'package:exam/feature/profile/domain/models/user_data_model.dart';
import 'package:exam/feature/profile/domain/use_case/edit_profile_use_case.dart';
import 'package:exam/feature/profile/domain/use_case/get_user_profile_use_case.dart';
import 'package:exam/feature/profile/presentation/view_model/states/profile_state.dart' show ProfileState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String? _lastLoadedUserId;

  ProfileCubit(this._getUserProfileUseCase, this._editProfileUseCase)
    : super(ProfileState());

  Future<void> getProfile() async {
    emit(
      state.copyWith(
        isLoadingParam: true,
        errorMessageParam: null,
        dataParam: null,
        updateSuccessParam: false,
      ),
    );
    final response = await _getUserProfileUseCase();
    switch (response) {
      case SuccessResponse<UserDataModel>():
        emit(state.copyWith(isLoadingParam: false, dataParam: response.data));
        break;
      case ErrorResponse<UserDataModel>():
        emit(
          state.copyWith(
            isLoadingParam: false,
            errorMessageParam: response.errorMessage,
          ),
        );
        break;
    }
  }

  void fillControllers(UserDataModel user, {bool force = false}) {
    if (!force && _lastLoadedUserId == user.id) return;

    usernameController.text = user.username;
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    emailController.text = user.email;
    phoneController.text = user.phone;
    _lastLoadedUserId = user.id;
  }

  Future<void> editProfile(EditProfileRequest request) async {
    emit(
      state.copyWith(
        isUpdatingParam: true,
        updateErrorMessageParam: null,
        updateSuccessParam: false,
      ),
    );

    final response = await _editProfileUseCase(request);
    switch (response) {
      case SuccessResponse<UserDataModel>():
        emit(
          state.copyWith(
            isUpdatingParam: false,
            dataParam: response.data,
            updateSuccessParam: true,
          ),
        );
        break;
      case ErrorResponse<UserDataModel>():
        emit(
          state.copyWith(
            isUpdatingParam: false,
            updateErrorMessageParam: response.errorMessage,
            updateSuccessParam: false,
          ),
        );
        break;
    }
  }

  Future<void> submitEditProfile() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    await editProfile(
      EditProfileRequest(
        username: usernameController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
      ),
    );
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
