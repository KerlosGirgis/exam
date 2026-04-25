sealed class ChangePasswordIntent {}

class ChangePasswordButtonPressed extends ChangePasswordIntent {
  final String oldPassword;
  final String password;
  final String rePassword;

  ChangePasswordButtonPressed({
    required this.oldPassword,
    required this.password,
    required this.rePassword,
  });
}
