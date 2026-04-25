import 'dart:async';
import 'package:dio/dio.dart';
import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/core/storage/secure_storage.dart';
import 'package:exam/feature/profile/api/profile_api_client/profile_api_client.dart';
import 'package:exam/feature/profile/data/data_sources/profile_remote_data_source_contract.dart';
import 'package:exam/feature/profile/data/models/request/edit_profile_request.dart';
import 'package:exam/feature/profile/data/models/user_data_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSourceContract {
  static const String _tokenKey = 'auth_token';

  final ProfileApiClient _profileApiClient;
  final SecureStorage _secureStorage;

  ProfileRemoteDataSourceImpl(this._profileApiClient, this._secureStorage);

  Future<String> _requireToken() async {
    final token = await _secureStorage.getToken(key: _tokenKey);
    if (token == null || token.isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(),
        message: 'User token not found',
      );
    }
    return token;
  }

  @override
  Future<BaseResponse<UserDataDto>> getProfile() async {
    try {
      final token = await _requireToken();
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
      final token = await _requireToken();
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
