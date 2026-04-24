import '../models/exam_dto.dart';

abstract interface class ExamRemoteDataSourceContract {
  Future<ExamResponseDto> getExamQuestions(String examId);
}
