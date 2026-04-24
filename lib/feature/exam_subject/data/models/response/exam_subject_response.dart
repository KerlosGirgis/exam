
import 'package:exam/feature/exam_subject/data/models/exam_subject_dto.dart';
import 'package:exam/feature/exam_subject/data/models/meta_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'exam_subject_response.g.dart';

@JsonSerializable()
class ExamSubjectResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "metadata")
  Metadata? metadata;
  @JsonKey(name: "exams")
  List<ExamSubjectDto>? exams;

  ExamSubjectResponse({this.message, this.metadata, this.exams});

  factory ExamSubjectResponse.fromJson(Map<String, dynamic> json) =>
      _$ExamSubjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExamSubjectResponseToJson(this);
}
