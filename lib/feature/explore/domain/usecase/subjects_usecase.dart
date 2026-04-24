import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/explore/domain/model/subject_model.dart';
import 'package:exam/feature/explore/domain/repo/explore_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubjectsUseCase {
  final ExploreRepo _exploreRepo;
  SubjectsUseCase(this._exploreRepo);

  Future<BaseResponse<List<SubjectModel>>> call() {
    return _exploreRepo.getAllSubjects();
  }
}
