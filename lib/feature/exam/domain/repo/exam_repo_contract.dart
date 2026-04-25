import '../../../../config/base_response/base_response.dart';
import '../models/exam_model.dart';

abstract interface class ExamRepoContract {
  Future<BaseResponse<ExamDetails>> getExamQuestions(String examId);
  Future<void> saveExamResult(Map<String, dynamic> result);
}
