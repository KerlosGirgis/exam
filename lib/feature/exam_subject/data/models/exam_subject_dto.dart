import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam_subject_dto.g.dart';

@JsonSerializable()
class ExamSubjectDto {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "numberOfQuestions")
  int? numberOfQuestions;
  @JsonKey(name: "active")
  bool? active;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;

  ExamSubjectDto({
    this.id,
    this.title,
    this.duration,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory ExamSubjectDto.fromJson(Map<String, dynamic> json) =>
      _$ExamSubjectDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExamSubjectDtoToJson(this);
  ExamSubjectModel toDomain() {
    return ExamSubjectModel(
      id: id ?? '',
      title: title ?? '',
      duration: duration ?? 0,
      numberOfQuestions: numberOfQuestions ?? 0,
    );
  }
}
