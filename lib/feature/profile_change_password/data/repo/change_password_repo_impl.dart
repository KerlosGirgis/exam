import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/profile_change_password/data/data_source/change_password_remote_data_source.dart';
import 'package:exam/feature/profile_change_password/data/model/change_password_response.dart';
import 'package:exam/feature/profile_change_password/domain/repo/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordRemoteDataSource _dataSource;

  ChangePasswordRepoImpl(this._dataSource);

  @override
  Future<BaseResponse<ChangePasswordModel>> changePassword({
    required String token,
    required String oldPassword,
    required String password,
    required String rePassword,
  }) async {
    try {
      final result = await _dataSource.changePassword(
        token: token,
        oldPassword: oldPassword,
        password: password,
        rePassword: rePassword,
      );
      return SuccessResponse<ChangePasswordModel>(data: result.toModel());
    } on DioException catch (e) {
      return ErrorResponse<ChangePasswordModel>(
        errorMessage: _mapDioException(e),
      );
    } on TimeoutException {
      return ErrorResponse<ChangePasswordModel>(
        errorMessage: 'Request timed out. Please try again.',
      );
    } on SocketException {
      return ErrorResponse<ChangePasswordModel>(
        errorMessage: 'No internet connection. Please check your network.',
      );
    } catch (_) {
      return ErrorResponse<ChangePasswordModel>(
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  String _mapDioException(DioException e) {
    final serverMessage = _extractServerMessage(e.response?.data);
    if (serverMessage != null) return serverMessage;

    if (e.response != null) {
      return _mapStatusCode(e.response!.statusCode);
    }
    return _mapDioErrorType(e.type);
  }

  String? _extractServerMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      for (final key in const ['message', 'error', 'msg']) {
        final value = data[key];
        if (value is String && value.trim().isNotEmpty) return value;
      }
    }
    if (data is String && data.trim().isNotEmpty) return data;
    return null;
  }

  String _mapStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your inputs.';
      case 401:
        return 'Your current password is incorrect.';
      case 403:
        return 'You are not allowed to perform this action.';
      case 404:
        return 'Service unavailable. Please try again later.';
      case 409:
        return 'New password must be different from the current password.';
      case 422:
        return 'Password does not meet the required format.';
      case 500:
      case 502:
      case 503:
        return 'Server error. Please try again later.';
      default:
        return 'Unable to change password. Please try again.';
    }
  }

  String _mapDioErrorType(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please connect and try again.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.badCertificate:
        return 'Secure connection failed.';
      case DioExceptionType.badResponse:
        return 'Received an invalid response from the server.';
      case DioExceptionType.unknown:
        return 'Network error. Please try again.';
    }
  }
}
