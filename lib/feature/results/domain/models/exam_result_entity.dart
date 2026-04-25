import '../../../exam/domain/models/exam_model.dart';

class ExamResultEntity {
  final String uid;
  final int score;
  final int total;
  final DateTime date;
  final String? examTitle;
  final String? subjectId;
  final String? subjectName;
  final String? subjectIcon;
  final List<QuestionEntity> questions;
  final Map<int, List<String>> userAnswers;

  ExamResultEntity({
    required this.uid,
    required this.score,
    required this.total,
    required this.date,
    this.examTitle,
    this.subjectId,
    this.subjectName,
    this.subjectIcon,
    required this.questions,
    required this.userAnswers,
  });
}
