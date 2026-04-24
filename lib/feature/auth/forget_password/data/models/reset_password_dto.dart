import 'package:exam/feature/auth/forget_password/domain/models/reset_password_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_dto.g.dart';

@JsonSerializable()
class ResetPasswordDto {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "token")
  String? token;

  ResetPasswordDto({this.message, this.token});

  factory ResetPasswordDto.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordDtoToJson(this);
  ResetPasswordModel toDomain() {
    return ResetPasswordModel(message: message ?? '', token: token ?? '');
  }
}
