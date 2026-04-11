import 'package:json_annotation/json_annotation.dart';
import 'subject_model_dto.dart';

part 'subject_response.g.dart';

@JsonSerializable()
class SubjectsResponseModel {
  final String? message;
  final List<SubjectModelDto>? subjects;

  SubjectsResponseModel({required this.message, required this.subjects});

  factory SubjectsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectsResponseModelToJson(this);
}
