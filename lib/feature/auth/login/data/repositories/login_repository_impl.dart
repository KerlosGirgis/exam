import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_local_data_source.dart';
import '../datasources/login_remote_data_source.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remote;
  final LoginLocalDataSource local;

  LoginRepositoryImpl(this.remote, this.local);

  @override
  Future<BaseResponse<(User, String)>> login(
    String email,
    String password, {
    required bool rememberMe,
  }) async {
    try {
      final response = await remote.login(email, password);
      if (rememberMe) {
        await local.saveToken(response.token);
      }
      return SuccessResponse(data: (response.user, response.token));
    } on DioException catch (e) {
      String errorMessage = 'An unexpected error occurred';

      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('code')) {
          final code = responseData['code'];
          errorMessage = _mapErrorCodeToMessage(code.toString(), statusCode);
        } else {
          errorMessage = _mapStatusCodeToMessage(statusCode);
        }
      } else {
        errorMessage = _mapDioErrorTypeToMessage(e.type);
      }

      return ErrorResponse(errorMessage: errorMessage);
    } catch (e) {
      return ErrorResponse(
          errorMessage: 'Something went wrong. Please try again.');
    }
  }

  String _mapErrorCodeToMessage(String code, int? statusCode) {
    switch (code) {
      case '401':
      case 'UNAUTHORIZED':
        return 'Invalid email or password. Please try again.';
      case '404':
      case 'NOT_FOUND':
        return 'Account not found. Please check your credentials.';
      case '400':
      case 'BAD_REQUEST':
        return 'The request was invalid. Please check your inputs.';
      case '500':
      case 'SERVER_ERROR':
        return 'Server is currently unavailable. Please try again later.';
      default:
        return _mapStatusCodeToMessage(statusCode);
    }
  }

  String _mapStatusCodeToMessage(int? statusCode) {
    switch (statusCode) {
      case 401:
        return 'Unauthorized: Invalid email or password.';
      case 404:
        return 'User not found. Please register first.';
      case 400:
        return 'Invalid request parameters.';
      case 500:
        return 'Internal server error. Please try again later.';
      default:
        return 'Connection error. Please check your internet.';
    }
  }

  String _mapDioErrorTypeToMessage(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet.';
      case DioExceptionType.badResponse:
        return 'Received an invalid response from the server.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please connect and try again.';
      default:
        return 'Network error. Please try again.';
    }
  }
}
