import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';

abstract class ExamSubjectRepoContract {
  Future<BaseResponse<List<ExamSubjectModel>>> getExams(String? subjectId);
}
