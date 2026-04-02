import 'package:json_annotation/json_annotation.dart';
import '../../domain/models/exam_model.dart';

part 'exam_dto.g.dart';

@JsonSerializable()
class ExamResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "questions")
  final List<QuestionDto>? questions;

  ExamResponseDto({this.message, this.questions});

  factory ExamResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExamResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResponseDtoToJson(this);

  ExamResponse toDomain() {
    return ExamResponse(
      message: message,
      questions: questions?.map((e) => e.toDomain()).toList(),
    );
  }
}

@JsonSerializable()
class QuestionDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "question")
  final String? question;
  @JsonKey(name: "answers")
  final List<AnswerDto>? answers;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "correct")
  final String? correct;
  @JsonKey(name: "subject")
  final dynamic subject;
  @JsonKey(name: "exam")
  final ExamDto? exam;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  QuestionDto({
    this.id,
    this.question,
    this.answers,
    this.type,
    this.correct,
    this.subject,
    this.exam,
    this.createdAt,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDtoToJson(this);

  Question toDomain() {
    return Question(
      id: id,
      question: question,
      answers: answers?.map((e) => e.toDomain()).toList(),
      type: type,
      correct: correct,
      subject: subject,
      exam: exam?.toDomain(),
      createdAt: createdAt,
    );
  }
}

@JsonSerializable()
class AnswerDto {
  @JsonKey(name: "answer")
  final String? answer;
  @JsonKey(name: "key")
  final String? key;

  AnswerDto({this.answer, this.key});

  factory AnswerDto.fromJson(Map<String, dynamic> json) =>
      _$AnswerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerDtoToJson(this);

  Answer toDomain() {
    return Answer(
      answer: answer,
      key: key,
    );
  }
}

@JsonSerializable()
class ExamDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "duration")
  final int? duration;
  @JsonKey(name: "subject")
  final String? subject;
  @JsonKey(name: "numberOfQuestions")
  final int? numberOfQuestions;
  @JsonKey(name: "active")
  final bool? active;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  ExamDto({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory ExamDto.fromJson(Map<String, dynamic> json) =>
      _$ExamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExamDtoToJson(this);

  Exam toDomain() {
    return Exam(
      id: id,
      title: title,
      duration: duration,
      subject: subject,
      numberOfQuestions: numberOfQuestions,
      active: active,
      createdAt: createdAt,
    );
  }
}
