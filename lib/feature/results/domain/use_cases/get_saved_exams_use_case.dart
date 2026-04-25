import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../models/exam_result_entity.dart';
import '../repo/results_repo_contract.dart';

@injectable
class GetSavedExamsUseCase {
  final ResultsRepoContract _repository;

  GetSavedExamsUseCase(this._repository);

  Future<BaseResponse<List<ExamResultEntity>>> call() async {
    return await _repository.getSavedExams();
  }
}
