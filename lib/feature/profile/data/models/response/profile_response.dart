import 'package:exam/feature/profile/data/models/user_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_response.g.dart';
@JsonSerializable()
class ProfileResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "user")
    UserDataDto? user;

    ProfileResponse({
        this.message,
        this.user,
    });

    factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);

    Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
