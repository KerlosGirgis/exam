class RegisterModel {
  final String message;
  final String token;
  final UserModel user;

  const RegisterModel({
    required this.message,
    required this.token,
    required this.user,
  });
}

class UserModel {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final bool isVerified;
  final String createdAt;

  const UserModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    required this.createdAt,
  });
}
