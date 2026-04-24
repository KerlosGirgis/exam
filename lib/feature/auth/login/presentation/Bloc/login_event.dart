abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  final bool rememberMe;

  LoginSubmitted({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}
