import '../../api/results_api_client/results_api_client.dart';

abstract class ResultsRemoteDataSourceContract {
  Future<SubjectResponse> getSubjectById(String id);
}
