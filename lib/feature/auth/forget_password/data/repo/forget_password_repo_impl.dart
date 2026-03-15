import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/auth/forget_password/data/data_sources/forget_password_remote_data_sources_contract.dart';
import 'package:exam/feature/auth/forget_password/data/models/forget_password_dto.dart';
import 'package:exam/feature/auth/forget_password/data/models/reset_password_dto.dart';
import 'package:exam/feature/auth/forget_password/data/models/verify_reset_code_dto.dart';
import 'package:exam/feature/auth/forget_password/domain/models/forget_password_model.dart';
import 'package:exam/feature/auth/forget_password/domain/models/reset_password_model.dart';
import 'package:exam/feature/auth/forget_password/domain/models/verify_reset_code_model.dart';
import 'package:exam/feature/auth/forget_password/domain/repo/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRepoContract)
class ForgetPasswordRepoImpl implements ForgetPasswordRepoContract {
  final ForgetPasswordRemoteDataSourcesContract forgetPasswordRemoteDataSources;

  ForgetPasswordRepoImpl(this.forgetPasswordRemoteDataSources);
  @override
  Future<BaseResponse<ForgetPasswordModel>> forgetPassword(
    String? email,
  ) async {
    final response = await forgetPasswordRemoteDataSources.forgetPassword(
      email: email,
    );

    switch (response) {
      case SuccessBaseResponse<ForgetPasswordDto>():
        return SuccessBaseResponse<ForgetPasswordModel>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<ForgetPasswordDto> errorResponse:
        return ErrorBaseResponse<ForgetPasswordModel>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<VerifyResetCodeModel>> verifyResetCode({
    String? resetCode,
  }) async {
    final response = await forgetPasswordRemoteDataSources.verifyResetCode(
      resetCode: resetCode,
    );
    switch (response) {
      case SuccessBaseResponse<VerifyResetCodeDto>():
        return SuccessBaseResponse<VerifyResetCodeModel>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<VerifyResetCodeDto> errorResponse:
        return ErrorBaseResponse<VerifyResetCodeModel>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<ResetPasswordModel>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final response = await forgetPasswordRemoteDataSources.resetPassword(
      email: email,
      newPassword: newPassword,
    );
    switch (response) {
      case SuccessBaseResponse<ResetPasswordDto>():
        return SuccessBaseResponse<ResetPasswordModel>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<ResetPasswordDto> errorResponse:
        return ErrorBaseResponse<ResetPasswordModel>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }
}
