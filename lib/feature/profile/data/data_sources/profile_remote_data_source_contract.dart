

import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/profile/data/models/request/edit_profile_request.dart';
import 'package:exam/feature/profile/data/models/user_data_dto.dart';

abstract class ProfileRemoteDataSourceContract {
  Future<BaseResponse<UserDataDto>> getProfile();
  Future<BaseResponse<UserDataDto>> editProfile(EditProfileRequest request);
}
