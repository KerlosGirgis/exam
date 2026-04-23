import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/utils/error_handler.dart';
import '../../domain/models/exam_model.dart';
import '../../domain/repo/exam_repo_contract.dart';
import '../data_sources/exam_remote_data_source_contract.dart';

@Injectable(as: ExamRepoContract)
class ExamRepoImpl implements ExamRepoContract {
  final ExamRemoteDataSourceContract _remoteDataSource;

  ExamRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<ExamResponse>> getExamQuestions(String examId) async {
    try {
      final response = await _remoteDataSource.getExamQuestions(examId);
      return SuccessResponse(data: response.toDomain());
    } catch (e) {
      return ErrorResponse(errorMessage: ErrorHandler.handle(e));
    }
  }
}
