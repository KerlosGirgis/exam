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
      case SuccessResponse<ForgetPasswordDto>():
        return SuccessResponse<ForgetPasswordModel>(
          data: response.data.toDomain(),
        );
      case ErrorResponse<ForgetPasswordDto> errorResponse:
        return ErrorResponse<ForgetPasswordModel>(
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
      case SuccessResponse<VerifyResetCodeDto>():
        return SuccessResponse<VerifyResetCodeModel>(
          data: response.data.toDomain(),
        );
      case ErrorResponse<VerifyResetCodeDto> errorResponse:
        return ErrorResponse<VerifyResetCodeModel>(
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
      case SuccessResponse<ResetPasswordDto>():
        return SuccessResponse<ResetPasswordModel>(
          data: response.data.toDomain(),
        );
      case ErrorResponse<ResetPasswordDto> errorResponse:
        return ErrorResponse<ResetPasswordModel>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }
}
