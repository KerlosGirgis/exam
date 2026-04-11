import 'package:exam/feature/auth/register/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "code")
  final String? code;

  @JsonKey(name: "token")
  final String? token;

  @JsonKey(name: "user")
  final UserResponse? user;

  RegisterResponse({this.message, this.code, this.token, this.user});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  RegisterModel toDomain() {
    return RegisterModel(
      message: message ?? "",
      token: token ?? "",
      user:
          user?.toModel() ??
          const UserModel(
            id: "",
            username: "",
            firstName: "",
            lastName: "",
            email: "",
            phone: "",
            role: "",
            isVerified: false,
            createdAt: "",
          ),
    );
  }
}

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "username")
  final String? username;

  @JsonKey(name: "firstName")
  final String? firstName;

  @JsonKey(name: "lastName")
  final String? lastName;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "role")
  final String? role;

  @JsonKey(name: "isVerified")
  final bool? isVerified;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  UserResponse({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.createdAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  UserModel toModel() {
    return UserModel(
      id: id ?? "",
      username: username ?? "",
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      email: email ?? "",
      phone: phone ?? "",
      role: role ?? "",
      isVerified: isVerified ?? false,
      createdAt: createdAt ?? "",
    );
  }
}
