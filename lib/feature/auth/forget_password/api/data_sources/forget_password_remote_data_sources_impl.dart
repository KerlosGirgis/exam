import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/core/constant/api_param.dart';
import 'package:exam/feature/auth/forget_password/api/forget_password_api_client/forget_password_api_client.dart';
import 'package:exam/feature/auth/forget_password/data/data_sources/forget_password_remote_data_sources_contract.dart';
import 'package:exam/feature/auth/forget_password/data/models/forget_password_dto.dart';
import 'package:dio/dio.dart';
import 'package:exam/feature/auth/forget_password/data/models/reset_password_dto.dart';
import 'package:exam/feature/auth/forget_password/data/models/verify_reset_code_dto.dart';
import 'dart:async';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRemoteDataSourcesContract)
class ForgetPasswordRemoteDataSourcesImpl
    implements ForgetPasswordRemoteDataSourcesContract {
  final ForgetPasswordApiClient forgetPasswordApiClient;

  ForgetPasswordRemoteDataSourcesImpl(this.forgetPasswordApiClient);
  @override
  Future<BaseResponse<ForgetPasswordDto>> forgetPassword({
    String? email,
  }) async {
    try {
      final response = await forgetPasswordApiClient.forgetPassword(
        body: {ApiParam.email: email},
      );
      return SuccessResponse<ForgetPasswordDto>(data: response);
    } catch (e) {
      if (e is DioException) {
        return ErrorResponse<ForgetPasswordDto>(
          errorMessage: e.message ?? 'Dio Exception',
        );
      } else if (e is TimeoutException) {
        return ErrorResponse<ForgetPasswordDto>(
          errorMessage: e.message ?? 'Request Time out ,Please try again later',
        );
      }
      return ErrorResponse<ForgetPasswordDto>(
        errorMessage: 'Something went wrong ,Please try again later',
      );
    }
  }

  @override
  Future<BaseResponse<VerifyResetCodeDto>> verifyResetCode({
    String? resetCode,
  }) async {
    try {
      final response = await forgetPasswordApiClient.verifyResetCode(
        body: {"resetCode": resetCode},
      );
      return SuccessResponse<VerifyResetCodeDto>(data: response);
    } catch (e) {
      if (e is DioException) {
        return ErrorResponse<VerifyResetCodeDto>(
          errorMessage: e.response?.data['message'] ?? 'Invalid Code',
        );
      }
      return ErrorResponse<VerifyResetCodeDto>(
        errorMessage: 'Something went wrong',
      );
    }
  }

  @override
  Future<BaseResponse<ResetPasswordDto>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await forgetPasswordApiClient.resetPassword(
        body: {ApiParam.email: email, ApiParam.newPassword: newPassword},
      );
      return SuccessResponse<ResetPasswordDto>(data: response);
    } catch (e) {
      if (e is DioException) {
        return ErrorResponse<ResetPasswordDto>(
          errorMessage: e.message ?? 'Dio Exception',
        );
      } else if (e is TimeoutException) {
        return ErrorResponse<ResetPasswordDto>(
          errorMessage: e.message ?? 'Request Time out ,Please try again later',
        );
      }
      return ErrorResponse<ResetPasswordDto>(
        errorMessage: 'Something went wrong ,Please try again later',
      );
    }
  }
}
