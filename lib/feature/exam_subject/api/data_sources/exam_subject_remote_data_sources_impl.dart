import 'dart:async';
import 'package:dio/dio.dart';
import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/exam_subject/api/exam_subject_api_client/exam_subject_api_client.dart';
import 'package:exam/feature/exam_subject/data/data_sources/exam_subject_remote_data_sources_contract.dart';
import 'package:exam/feature/exam_subject/data/models/exam_subject_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamSubjectRemoteDataSourcesContract)
class ExamSubjectRemoteDataSourcesImpl
    implements ExamSubjectRemoteDataSourcesContract {
  final ExamSubjectApiClient examSubjectApiClient;

  ExamSubjectRemoteDataSourcesImpl(this.examSubjectApiClient);
  @override
  Future<BaseResponse<List<ExamSubjectDto>>> getExams(String? subjectId) async {
    try {
      const String myToken =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5YWI2NzQxY2ViMmM1OWY4NGEzYzg0MSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzc0NjYzOTg3fQ.q1-dD6IqBmMD20Wo5F_N2of_gBbM33Bknq2L_vxZpMo";
      final response = await examSubjectApiClient.getExamsOnSubject(
        token: myToken,
        subjectId: subjectId ?? '',
      );
      return SuccessResponse<List<ExamSubjectDto>>(data: response.exams ?? []);
    } catch (e) {
      if (e is DioException) {
        return ErrorResponse<List<ExamSubjectDto>>(
          errorMessage: e.message ?? 'Dio Exception',
        );
      } else if (e is TimeoutException) {
        return ErrorResponse<List<ExamSubjectDto>>(
          errorMessage: e.message ?? 'Request Time out ,Please try again later',
        );
      }
      return ErrorResponse<List<ExamSubjectDto>>(
        errorMessage: 'Something went wrong ,Please try again later',
      );
    }
  }
}
