import 'package:exam/feature/profile_change_password/api/services/change_password_service.dart';
import 'package:exam/feature/profile_change_password/data/data_source/change_password_remote_data_source.dart';
import 'package:exam/feature/profile_change_password/data/model/change_password_request.dart';
import 'package:exam/feature/profile_change_password/data/model/change_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRemoteDataSource)
class ChangePasswordRemoteDataSourceImpl implements ChangePasswordRemoteDataSource {
  final ChangePasswordService _changePasswordService;

  ChangePasswordRemoteDataSourceImpl(this._changePasswordService);

  @override
  Future<ChangePasswordResponse> changePassword({
    required String token,
    required String oldPassword,
    required String password,
    required String rePassword,
  }) =>
      _changePasswordService.changePassword(
        token,
        ChangePasswordRequest(
          oldPassword: oldPassword,
          password: password,
          rePassword: rePassword,
        ),
      );
}
