class ExamResponse {
  final String? message;
  final List<Question>? questions;

  ExamResponse({this.message, this.questions});
}

class Question {
  final String? id;
  final String? question;
  final List<Answer>? answers;
  final String? type;
  final String? correct;
  final dynamic subject;
  final Exam? exam;
  final String? createdAt;

  Question({
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

class Answer {
  final String? answer;
  final String? key;

  Answer({this.answer, this.key});
}

class Exam {
  final String? id;
  final String? title;
  final int? duration;
  final String? subject;
  final int? numberOfQuestions;
  final bool? active;
  final String? createdAt;

  Exam({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });
}
