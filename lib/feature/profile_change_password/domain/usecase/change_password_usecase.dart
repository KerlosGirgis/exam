import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/profile_change_password/data/model/change_password_response.dart';
import 'package:exam/feature/profile_change_password/domain/repo/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepo _repo;

  ChangePasswordUseCase(this._repo);

  Future<BaseResponse<ChangePasswordModel>> call({
    required String token,
    required String oldPassword,
    required String password,
    required String rePassword,
  }) {
    return _repo.changePassword(
      token: token,
      oldPassword: oldPassword,
      password: password,
      rePassword: rePassword,
    );
  }
}
