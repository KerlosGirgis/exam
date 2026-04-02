import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/models/exam_model.dart';
import '../../domain/repo/exam_repo_contract.dart';
import '../data_sources/exam_local_data_source_contract.dart';
import '../data_sources/exam_remote_data_source_contract.dart';

@Injectable(as: ExamRepoContract)
class ExamRepoImpl implements ExamRepoContract {
  final ExamRemoteDataSourceContract _remoteDataSource;
  final ExamLocalDataSourceContract _localDataSource;

  ExamRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<BaseResponse<ExamResponse>> getExamQuestions(String examId) async {
    try {
      final response = await _remoteDataSource.getExamQuestions(examId);
      return SuccessResponse(data: response.toDomain());
    } catch (e) {
      try {
        final localResponse = await _localDataSource.getExamQuestions(examId);
        return SuccessResponse(data: localResponse.toDomain());
      } catch (localError) {
        String errorMessage = 'An unexpected error occurred';

        if (e is DioException) {
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
        }

        return ErrorResponse(errorMessage: errorMessage);
      }
    }
  }

  String _mapErrorCodeToMessage(String code, int? statusCode) {
    switch (code) {
      case '401':
      case 'UNAUTHORIZED':
        return 'Unauthorized access. Please login again.';
      case '404':
      case 'NOT_FOUND':
        return 'Exam not found.';
      case '400':
      case 'BAD_REQUEST':
        return 'The request was invalid. Please try again.';
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
        return 'Unauthorized access.';
      case 404:
        return 'Not found.';
      case 400:
        return 'Invalid request.';
      case 500:
        return 'Internal server error.';
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
