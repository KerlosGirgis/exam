import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/exam_subject/data/data_sources/exam_subject_remote_data_sources_contract.dart';
import 'package:exam/feature/exam_subject/data/models/exam_subject_dto.dart';
import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';
import 'package:exam/feature/exam_subject/domain/repo/exam_subject_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamSubjectRepoContract)
class ExamSubjectRepoImpl implements ExamSubjectRepoContract {
  final ExamSubjectRemoteDataSourcesContract examSubjectRemoteDataSources;

  ExamSubjectRepoImpl(this.examSubjectRemoteDataSources);
  @override
  Future<BaseResponse<List<ExamSubjectModel>>> getExams(
    String? subjectId,
  ) async {
    final response = await examSubjectRemoteDataSources.getExams(subjectId);
    switch (response) {
      case SuccessResponse<List<ExamSubjectDto>>():
        return SuccessResponse<List<ExamSubjectModel>>(
          data: response.data.map((e) => e.toDomain()).toList(),
        );
      case ErrorResponse<List<ExamSubjectDto>> errorResponse:
        return ErrorResponse<List<ExamSubjectModel>>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }
}
