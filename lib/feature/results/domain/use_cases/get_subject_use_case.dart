import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../explore/domain/model/subject_entity.dart';
import '../repo/results_repo_contract.dart';

@injectable
class GetSubjectUseCase {
  final ResultsRepoContract _repository;

  GetSubjectUseCase(this._repository);

  Future<BaseResponse<SubjectEntity>> call(String subjectId) async {
    return await _repository.getSubjectById(subjectId);
  }
}
