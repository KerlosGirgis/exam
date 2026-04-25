import 'package:exam/core/storage/secure_storage.dart';
import 'package:exam/feature/profile_change_password/api/services/change_password_service.dart';
import 'package:exam/feature/profile_change_password/data/data_source/change_password_remote_data_source.dart';
import 'package:exam/feature/profile_change_password/data/model/change_password_request.dart';
import 'package:exam/feature/profile_change_password/data/model/change_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRemoteDataSource)
class ChangePasswordRemoteDataSourceImpl implements ChangePasswordRemoteDataSource {
  final ChangePasswordService changePasswordService;
  final SecureStorage secureStorage;

  ChangePasswordRemoteDataSourceImpl({
    required this.changePasswordService,
    required this.secureStorage,
  });

  static const String _tokenKey = 'auth_token';

  @override
  Future<ChangePasswordResponse> changePassword({
    required String token,
    required String oldPassword,
    required String password,
    required String rePassword,
  }) async {
    final request = ChangePasswordRequest(
      oldPassword: oldPassword,
      password: password,
      rePassword: rePassword,
    );

    final response = await changePasswordService.changePassword(
      token,
      request,
    );

    if (response.token != null) {
      await secureStorage.saveToken(response.token!, key: _tokenKey);
    }

    return response;
  }
}
