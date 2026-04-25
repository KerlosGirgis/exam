import 'package:injectable/injectable.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../data/data_sources/results_remote_data_source_contract.dart';
import '../results_api_client/results_api_client.dart';

@Injectable(as: ResultsRemoteDataSourceContract)
class ResultsRemoteDataSourceImpl implements ResultsRemoteDataSourceContract {
  final ResultsApiClient _apiClient;
  final SecureStorage _secureStorage;
  static const String _tokenKey = 'auth_token';

  ResultsRemoteDataSourceImpl(this._apiClient, this._secureStorage);

  @override
  Future<SubjectResponse> getSubjectById(String id) async {
    final token = await _secureStorage.getToken(key: _tokenKey);
    return await _apiClient.getSubjectById(token ?? '', id);
  }
}
