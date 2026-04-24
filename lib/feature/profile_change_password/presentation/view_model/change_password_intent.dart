sealed class ChangePasswordIntent {}

class ChangePasswordButtonPressed extends ChangePasswordIntent {
  final String token;
  final String oldPassword;
  final String password;
  final String rePassword;

  ChangePasswordButtonPressed({
    required this.token,
    required this.oldPassword,
    required this.password,
    required this.rePassword,
  });
}
