sealed class RegisterIntent {}

class DoRegisterIntent extends RegisterIntent {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  DoRegisterIntent({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });
}

class CheckFormFilledIntent extends RegisterIntent {
  final bool isFilled;
  CheckFormFilledIntent(this.isFilled);
}
