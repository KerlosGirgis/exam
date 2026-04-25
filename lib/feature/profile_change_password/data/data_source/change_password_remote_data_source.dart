import 'package:exam/feature/profile_change_password/data/model/change_password_response.dart';

abstract interface class ChangePasswordRemoteDataSource {
  Future<ChangePasswordResponse> changePassword({
    required String token,
    required String oldPassword,
    required String password,
    required String rePassword,
  });
}
