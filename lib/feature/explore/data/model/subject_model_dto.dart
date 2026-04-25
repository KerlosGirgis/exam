import 'package:exam/feature/explore/domain/model/subject_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject_model_dto.g.dart';

@JsonSerializable()
class SubjectModelDto {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'icon')
  final String? icon;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  SubjectModelDto({this.id, this.name, this.icon, this.createdAt});

  factory SubjectModelDto.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectModelDtoToJson(this);

  SubjectEntity toEntity() {
    return SubjectEntity(id: id, name: name, icon: icon, createdAt: createdAt);
  }
}
