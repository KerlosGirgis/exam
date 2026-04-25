// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamResponseDto _$ExamResponseDtoFromJson(Map<String, dynamic> json) =>
    ExamResponseDto(
      message: json['message'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamResponseDtoToJson(ExamResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'questions': instance.questions,
    };

QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) => QuestionDto(
  id: json['_id'] as String?,
  question: json['question'] as String?,
  answers: (json['answers'] as List<dynamic>?)
      ?.map((e) => AnswerDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  type: json['type'] as String?,
  correct: json['correct'] as String?,
  subject: json['subject'],
  exam: json['exam'] == null
      ? null
      : ExamDto.fromJson(json['exam'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$QuestionDtoToJson(QuestionDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
      'type': instance.type,
      'correct': instance.correct,
      'subject': instance.subject,
      'exam': instance.exam,
      'createdAt': instance.createdAt,
    };

AnswerDto _$AnswerDtoFromJson(Map<String, dynamic> json) =>
    AnswerDto(answer: json['answer'] as String?, key: json['key'] as String?);

Map<String, dynamic> _$AnswerDtoToJson(AnswerDto instance) => <String, dynamic>{
  'answer': instance.answer,
  'key': instance.key,
};

ExamDto _$ExamDtoFromJson(Map<String, dynamic> json) => ExamDto(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  subject: json['subject'] as String?,
  numberOfQuestions: (json['numberOfQuestions'] as num?)?.toInt(),
  active: json['active'] as bool?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$ExamDtoToJson(ExamDto instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'duration': instance.duration,
  'subject': instance.subject,
  'numberOfQuestions': instance.numberOfQuestions,
  'active': instance.active,
  'createdAt': instance.createdAt,
};
