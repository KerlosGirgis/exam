import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/auth/forget_password/domain/models/forget_password_model.dart';
import 'package:exam/feature/auth/forget_password/domain/models/reset_password_model.dart';
import 'package:exam/feature/auth/forget_password/domain/models/verify_reset_code_model.dart';

abstract class ForgetPasswordRepoContract {
  Future<BaseResponse<ForgetPasswordModel>> forgetPassword(String? email);
  Future<BaseResponse<VerifyResetCodeModel>> verifyResetCode({
    String? resetCode,
  });
  Future<BaseResponse<ResetPasswordModel>> resetPassword({
    required String email,
    required String newPassword,
  });
}
