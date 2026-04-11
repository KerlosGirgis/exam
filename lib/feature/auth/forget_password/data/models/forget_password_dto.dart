import 'package:exam/feature/auth/forget_password/domain/models/forget_password_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_dto.g.dart';

@JsonSerializable()
class ForgetPasswordDto {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "info")
  String? info;

  ForgetPasswordDto({this.message, this.info});
  ForgetPasswordModel toDomain() {
    return ForgetPasswordModel(message: message ?? '', info: info ?? '');
  }

  factory ForgetPasswordDto.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordDtoToJson(this);
}
