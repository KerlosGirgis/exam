// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_subject_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamSubjectResponse _$ExamSubjectResponseFromJson(Map<String, dynamic> json) =>
    ExamSubjectResponse(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      exams: (json['exams'] as List<dynamic>?)
          ?.map((e) => ExamSubjectDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamSubjectResponseToJson(
  ExamSubjectResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'exams': instance.exams,
};
