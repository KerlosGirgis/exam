import 'package:injectable/injectable.dart';

import '../../../../core/storage/secure_storage.dart';
import '../../data/data_sources/exam_remote_data_source_contract.dart';
import '../../data/models/exam_dto.dart';
import '../exam_api_client/exam_api_client.dart';

@Injectable(as: ExamRemoteDataSourceContract)
class ExamRemoteDataSourceImpl implements ExamRemoteDataSourceContract {
  final ExamApiClient _apiClient;
  final SecureStorage _secureStorage;
  static const String _tokenKey = 'auth_token';

  ExamRemoteDataSourceImpl(this._apiClient, this._secureStorage);

  @override
  Future<ExamResponseDto> getExamQuestions(String examId) async {
    final token = await _secureStorage.getToken(key: _tokenKey);
    return await _apiClient.getExamQuestions(token ?? '', examId);
  }
}
