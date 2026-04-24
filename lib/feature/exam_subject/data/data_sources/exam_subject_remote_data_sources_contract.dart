import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/exam_subject/data/models/exam_subject_dto.dart';

abstract class ExamSubjectRemoteDataSourcesContract {
  Future<BaseResponse<List<ExamSubjectDto>>> getExams(String? subjectId);
}
