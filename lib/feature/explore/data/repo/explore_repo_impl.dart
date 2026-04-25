import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/core/constant/storage_keys.dart';
import 'package:exam/core/storage/secure_storage.dart';
import 'package:exam/core/utils/error_message_mapper.dart';
import 'package:exam/feature/explore/data/data_source/explore_remote_datasource.dart';
import 'package:exam/feature/explore/domain/model/subject_entity.dart';
import 'package:exam/feature/explore/domain/repo/explore_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExploreRepo)
class ExploreRepoImp implements ExploreRepo {
  final ExploreRemoteDatasource _exploreDataSource;
  final SecureStorage _secureStorage;

  ExploreRepoImp(this._exploreDataSource, this._secureStorage);

  @override
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects() async {
    try {
      final token = await _secureStorage.getToken(key: StorageKeys.authToken);
      if (token == null || token.isEmpty) {
        return ErrorResponse<List<SubjectEntity>>(
          errorMessage: 'Authentication required. Please sign in again.',
        );
      }
      final result = await _exploreDataSource.getAllSubject(token: token);
      return SuccessResponse<List<SubjectEntity>>(
        data: result.map((dto) => dto.toEntity()).toList(),
      );
    } catch (e) {
      return ErrorResponse<List<SubjectEntity>>(
        errorMessage: ErrorMessageMapper.fromException(e),
      );
    }
  }
}
