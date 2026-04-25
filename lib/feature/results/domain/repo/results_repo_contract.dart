import '../../../../config/base_response/base_response.dart';
import '../../../explore/domain/model/subject_entity.dart';
import '../models/exam_result_entity.dart';

abstract class ResultsRepoContract {
  Future<BaseResponse<List<ExamResultEntity>>> getSavedExams();
  Future<BaseResponse<SubjectEntity>> getSubjectById(String subjectId);
}
