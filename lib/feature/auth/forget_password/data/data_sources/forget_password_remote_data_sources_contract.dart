import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/auth/forget_password/data/models/forget_password_dto.dart';
import 'package:exam/feature/auth/forget_password/data/models/reset_password_dto.dart';
import 'package:exam/feature/auth/forget_password/data/models/verify_reset_code_dto.dart';

abstract class ForgetPasswordRemoteDataSourcesContract {
  Future<BaseResponse<ForgetPasswordDto>> forgetPassword({String? email});
  Future<BaseResponse<VerifyResetCodeDto>> verifyResetCode({String? resetCode});
  Future<BaseResponse<ResetPasswordDto>> resetPassword({
  required  String email,
  required  String newPassword,
  });
}
