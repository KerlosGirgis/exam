import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/profile/data/models/request/edit_profile_request.dart';
import 'package:exam/feature/profile/domain/models/user_data_model.dart';
import 'package:exam/feature/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final ProfileRepoContract _profileRepoContract;

  EditProfileUseCase(this._profileRepoContract);

  Future<BaseResponse<UserDataModel>> call(EditProfileRequest request) async {
    return _profileRepoContract.editProfile(request);
  }
}
