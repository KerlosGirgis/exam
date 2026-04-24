class ExamDetails {
  final String? message;
  final List<QuestionEntity>? questions;

  ExamDetails({this.message, this.questions});
}

class QuestionEntity {
  final String? id;
  final String? question;
  final List<AnswerEntity>? answers;
  final String? type;
  final String? correct;
  final dynamic subject;
  final ExamEntity? exam;
  final String? createdAt;

  QuestionEntity({
    this.id,
    this.question,
    this.answers,
    this.type,
    this.correct,
    this.subject,
    this.exam,
    this.createdAt,
  });
}

class AnswerEntity {
  final String? answer;
  final String? key;

  AnswerEntity({this.answer, this.key});
}

class ExamEntity {
  final String? id;
  final String? title;
  final int? duration;
  final String? subject;
  final int? numberOfQuestions;
  final bool? active;
  final String? createdAt;

  ExamEntity({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });
}
