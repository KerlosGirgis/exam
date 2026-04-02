import '../../../../config/base_response/base_response.dart';
import '../models/exam_model.dart';

abstract class ExamRepoContract {
  Future<BaseResponse<ExamResponse>> getExamQuestions(String examId);
}
