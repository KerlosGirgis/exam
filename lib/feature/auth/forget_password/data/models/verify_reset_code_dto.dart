import 'package:exam/feature/auth/forget_password/domain/models/verify_reset_code_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'verify_reset_code_dto.g.dart';

@JsonSerializable()
class VerifyResetCodeDto {
  @JsonKey(name: "status")
  String? status;

  VerifyResetCodeDto({this.status});

  factory VerifyResetCodeDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetCodeDtoToJson(this);
  VerifyResetCodeModel toDomain() {
    return VerifyResetCodeModel(status: status ?? '');
  }
}
