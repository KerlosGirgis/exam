import 'package:injectable/injectable.dart';
import '../repo/exam_repo_contract.dart';

@injectable
class StoreExamResultUseCase {
  final ExamRepoContract _repository;

  StoreExamResultUseCase(this._repository);

  Future<void> call(Map<String, dynamic> result) async {
    return await _repository.saveExamResult(result);
  }
}
