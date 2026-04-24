import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/profile/data/data_sources/profile_remote_data_source_contract.dart';
import 'package:exam/feature/profile/data/models/request/edit_profile_request.dart';
import 'package:exam/feature/profile/data/models/user_data_dto.dart';
import 'package:exam/feature/profile/domain/models/user_data_model.dart';
import 'package:exam/feature/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl implements ProfileRepoContract {
  final ProfileRemoteDataSourceContract _profileRemoteDataSourceContract;

  ProfileRepoImpl(this._profileRemoteDataSourceContract);
  @override
  Future<BaseResponse<UserDataModel>> getProfile() async {
    final response = await _profileRemoteDataSourceContract.getProfile();
    switch (response) {
      case SuccessResponse<UserDataDto>():
        return SuccessResponse<UserDataModel>(data: response.data.toDomain());
      case ErrorResponse<UserDataDto> errorResponse:
        return ErrorResponse<UserDataModel>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<UserDataModel>> editProfile(EditProfileRequest request) async {
    final response = await _profileRemoteDataSourceContract.editProfile(request);
    switch (response) {
      case SuccessResponse<UserDataDto>():
        return SuccessResponse<UserDataModel>(data: response.data.toDomain());
      case ErrorResponse<UserDataDto> errorResponse:
        return ErrorResponse<UserDataModel>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }
}
