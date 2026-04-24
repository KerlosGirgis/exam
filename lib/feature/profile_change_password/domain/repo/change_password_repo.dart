import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/profile_change_password/data/model/change_password_response.dart';

abstract class ChangePasswordRepo {
  Future<BaseResponse<ChangePasswordModel>> changePassword({
    required String token,
    required String oldPassword,
    required String password,
    required String rePassword,
  });
}
