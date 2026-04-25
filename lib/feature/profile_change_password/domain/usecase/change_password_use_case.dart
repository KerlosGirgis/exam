import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/profile_change_password/domain/model/change_password_details.dart';
import 'package:exam/feature/profile_change_password/domain/repo/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepo _repo;

  ChangePasswordUseCase(this._repo);

  Future<BaseResponse<ChangePasswordDetails>> call({
    required String oldPassword,
    required String password,
    required String rePassword,
  }) =>
      _repo.changePassword(
        oldPassword: oldPassword,
        password: password,
        rePassword: rePassword,
      );
}
