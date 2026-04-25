// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_subject_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamSubjectDto _$ExamSubjectDtoFromJson(Map<String, dynamic> json) =>
    ExamSubjectDto(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      numberOfQuestions: (json['numberOfQuestions'] as num?)?.toInt(),
      active: json['active'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ExamSubjectDtoToJson(ExamSubjectDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'duration': instance.duration,
      'numberOfQuestions': instance.numberOfQuestions,
      'active': instance.active,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
