import 'dart:async';
import 'package:dio/dio.dart';
import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/profile/api/profile_api_client/profile_api_client.dart';
import 'package:exam/feature/profile/data/data_sources/profile_remote_data_source_contract.dart';
import 'package:exam/feature/profile/data/models/request/edit_profile_request.dart';
import 'package:exam/feature/profile/data/models/user_data_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSourceContract {
  final ProfileApiClient _profileApiClient;
  // final LoginLocalDataSource _loginLocalDataSource;

  ProfileRemoteDataSourceImpl(
    this._profileApiClient,
    // this._loginLocalDataSource,
  );

  // Future<String> _getToken() async {
  //   final token = await _loginLocalDataSource.getToken();
  //   if (token == null || token.isEmpty) {
  //     throw DioException(
  //       requestOptions: RequestOptions(),
  //       message: 'User token not found',
  //     );
  //   }
  //   return token;
  // }

  @override
  Future<BaseResponse<UserDataDto>> getProfile() async {
    try {
      final token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZTY0ODcxMDRkYTBkNGNmNTU2YmViNSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzc2ODU5Mzc2fQ.8VGrfWk2MyOpdEpX0zXZy0QiNQcFo9hSZ56zS7QJAOU';
      final response = await _profileApiClient.getUserProfile(token);
      return SuccessResponse<UserDataDto>(data: response.user!);
    } catch (e) {
      if (e is DioException) {
        return ErrorResponse<UserDataDto>(
          errorMessage: e.message ?? 'Dio Exception',
        );
      } else if (e is TimeoutException) {
        return ErrorResponse<UserDataDto>(
          errorMessage: e.message ?? 'Request Time out ,Please try again later',
        );
      }
      return ErrorResponse<UserDataDto>(
        errorMessage: 'Something went wrong ,Please try again later',
      );
    }
  }

  @override
  Future<BaseResponse<UserDataDto>> editProfile(
    EditProfileRequest request,
  ) async {
    try {
      final token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZTY0ODcxMDRkYTBkNGNmNTU2YmViNSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzc2ODU5Mzc2fQ.8VGrfWk2MyOpdEpX0zXZy0QiNQcFo9hSZ56zS7QJAOU';
      final response = await _profileApiClient.editProfile(token, request);
      return SuccessResponse<UserDataDto>(data: response.user!);
    } catch (e) {
      if (e is DioException) {
        return ErrorResponse<UserDataDto>(
          errorMessage: e.message ?? 'Dio Exception',
        );
      } else if (e is TimeoutException) {
        return ErrorResponse<UserDataDto>(
          errorMessage: e.message ?? 'Request Time out ,Please try again later',
        );
      }
      return ErrorResponse<UserDataDto>(
        errorMessage: 'Something went wrong ,Please try again later',
      );
    }
  }
}
