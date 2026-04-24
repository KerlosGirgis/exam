import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/profile_change_password/data/data_source/change_password_remote_data_source.dart';
import 'package:exam/feature/profile_change_password/data/model/change_password_response.dart';
import 'package:exam/feature/profile_change_password/domain/repo/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordRemoteDataSource _dataSource;

  ChangePasswordRepoImpl(this._dataSource);

  @override
  Future<BaseResponse<ChangePasswordModel>> changePassword({
    required String token,
    required String oldPassword,
    required String password,
    required String rePassword,
  }) async {
    try {
      final result = await _dataSource.changePassword(
        token: token,
        oldPassword: oldPassword,
        password: password,
        rePassword: rePassword,
      );
      return SuccessResponse<ChangePasswordModel>(data: result.toModel());
    } catch (e) {
      return ErrorResponse<ChangePasswordModel>(
        errorMessage: e.toString(),
      );
    }
  }
}
