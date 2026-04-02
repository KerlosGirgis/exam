import '../models/exam_dto.dart';

abstract class ExamLocalDataSourceContract {
  Future<ExamResponseDto> getExamQuestions(String examId);
}
