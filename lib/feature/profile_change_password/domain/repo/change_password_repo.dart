import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/profile_change_password/domain/model/change_password_details.dart';

abstract interface class ChangePasswordRepo {
  Future<BaseResponse<ChangePasswordDetails>> changePassword({
    required String oldPassword,
    required String password,
    required String rePassword,
  });
}
