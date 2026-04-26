import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../core/utils/error_handler.dart';
import '../../../exam/domain/models/exam_model.dart';
import '../../../explore/domain/model/subject_entity.dart';
import '../../domain/models/exam_result_entity.dart';
import '../../domain/repo/results_repo_contract.dart';
import '../data_sources/results_local_data_source_contract.dart';
import '../data_sources/results_remote_data_source_contract.dart';

@Injectable(as: ResultsRepoContract)
class ResultsRepoImpl implements ResultsRepoContract {
  final ResultsLocalDataSourceContract _localDataSource;
  final ResultsRemoteDataSourceContract _remoteDataSource;

  ResultsRepoImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<BaseResponse<List<ExamResultEntity>>> getSavedExams() async {
    try {
      final data = await _localDataSource.getSavedExams();
      final List<ExamResultEntity> results = [];

      data.forEach((key, value) {
        try {
          if (value is! Map) return;
          final map = value;
          
          final questionsList = map['questions'] as List?;
          final questions = questionsList?.map((q) {
            final qMap = q as Map;
            final answersList = qMap['answers'] as List?;
            return QuestionEntity(
              id: qMap['id']?.toString(),
              question: qMap['question']?.toString(),
              correct: qMap['correct']?.toString(),
              answers: answersList?.map((a) {
                final aMap = a as Map;
                return AnswerEntity(
                  answer: aMap['answer']?.toString(),
                  key: aMap['key']?.toString(),
                );
              }).toList(),
            );
          }).toList() ?? [];

          final userAnswersRaw = map['userAnswers'] as Map?;
          final Map<int, List<String>> userAnswers = {};
          userAnswersRaw?.forEach((k, v) {
            final intKey = int.tryParse(k.toString());
            if (intKey != null && v is List) {
              userAnswers[intKey] = List<String>.from(v.map((e) => e.toString()));
            }
          });

          results.add(ExamResultEntity(
            uid: key.toString(),
            score: int.tryParse(map['score']?.toString() ?? '0') ?? 0,
            total: int.tryParse(map['total']?.toString() ?? '0') ?? 0,
            date: DateTime.tryParse(map['date']?.toString() ?? '') ?? DateTime.now(),
            examTitle: map['examTitle']?.toString(),
            subjectId: map['subjectId']?.toString(),
            subjectName: map['subjectName']?.toString(),
            subjectIcon: map['subjectIcon']?.toString(),
            questions: questions,
            userAnswers: userAnswers,
          ));
        } catch (e) {
          // Skip individual failed records
        }
      });

      results.sort((a, b) => b.date.compareTo(a.date));
      return SuccessResponse(data: results);
    } catch (e) {
      return ErrorResponse(errorMessage: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<SubjectEntity>> getSubjectById(String subjectId) async {
    try {
      final response = await _remoteDataSource.getSubjectById(subjectId);
      return SuccessResponse(data: response.subject?.toEntity() ?? const SubjectEntity());
    } catch (e) {
      return ErrorResponse(errorMessage: ErrorHandler.handle(e));
    }
  }
}
