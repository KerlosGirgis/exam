import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/explore/data/data_source/explore_remote_datasource.dart';
import 'package:exam/feature/explore/domain/model/subject_model.dart';
import 'package:exam/feature/explore/domain/repo/explore_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExploreRepo)
class ExploreRepoImp implements ExploreRepo {
  final ExploreRemoteDatasource _exploreDataSource;
  ExploreRepoImp(this._exploreDataSource);

  @override
  Future<BaseResponse<List<SubjectModel>>> getAllSubjects() async {
    try {
      var result = await _exploreDataSource.getAllSubject();
      return SuccessResponse<List<SubjectModel>>(
        data: result.map((dto) => dto.toModel()).toList(),
      );
    } catch (e) {
      return ErrorResponse<List<SubjectModel>>(
        errorMessage: 'An error occurred while fetching subjects.',
      );
    }
  }
}
