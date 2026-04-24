import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/utils/error_handler.dart';
import '../../domain/models/exam_model.dart';
import '../../domain/repo/exam_repo_contract.dart';
import '../data_sources/exam_local_data_source_contract.dart';
import '../data_sources/exam_remote_data_source_contract.dart';

@Injectable(as: ExamRepoContract)
class ExamRepoImpl implements ExamRepoContract {
  final ExamRemoteDataSourceContract _remoteDataSource;
  final ExamLocalDataSourceContract _localDataSource;

  ExamRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<BaseResponse<ExamDetails>> getExamQuestions(String examId) async {
    try {
      final response = await _remoteDataSource.getExamQuestions(examId);
      return SuccessResponse(data: response.toDomain());
    } catch (e) {
      return ErrorResponse(errorMessage: ErrorHandler.handle(e));
    }
  }

  @override
  Future<void> saveExamResult(Map<String, dynamic> result) async {
    await _localDataSource.saveExamResult(result);
  }
}
