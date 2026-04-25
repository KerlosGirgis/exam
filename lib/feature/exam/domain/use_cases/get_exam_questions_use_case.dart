import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../models/exam_model.dart';
import '../repo/exam_repo_contract.dart';

@injectable
class GetExamQuestionsUseCase {
  final ExamRepoContract _repository;

  GetExamQuestionsUseCase(this._repository);

  Future<BaseResponse<ExamDetails>> call(String examId) {
    return _repository.getExamQuestions(examId);
  }
}
