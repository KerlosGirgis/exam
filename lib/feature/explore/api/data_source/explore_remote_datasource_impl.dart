import 'package:exam/core/storage/secure_storage.dart';
import 'package:exam/feature/explore/api/services/explore_services.dart';
import 'package:exam/feature/explore/data/data_source/explore_remote_datasource.dart';
import 'package:exam/feature/explore/data/model/subject_model_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExploreRemoteDatasource)
class ExploreDataSourceImp extends ExploreRemoteDatasource {
  final ExploreService exploreService;
  final SecureStorage secureStorage;

  ExploreDataSourceImp(this.exploreService, this.secureStorage);

  static const String _tokenKey = 'auth_token';

  @override
  Future<List<SubjectModelDto>> getAllSubject() async {
    final token = await secureStorage.getToken(key: _tokenKey);
    if (token == null) {
      throw Exception("Token is missing");
    } else {
      final response = await exploreService.getAllSubjects(token);
      return response.subjects ?? [];
    }
  }
}
