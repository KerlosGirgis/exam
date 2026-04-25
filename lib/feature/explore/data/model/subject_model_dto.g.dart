// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectModelDto _$SubjectModelDtoFromJson(Map<String, dynamic> json) =>
    SubjectModelDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SubjectModelDtoToJson(SubjectModelDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
