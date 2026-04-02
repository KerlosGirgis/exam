import '../models/exam_dto.dart';

abstract class ExamRemoteDataSourceContract {
  Future<ExamResponseDto> getExamQuestions(String examId);
}
