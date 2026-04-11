abstract class EndPoint {
  EndPoint._();
  static const String baseUrl = 'https://exam.elevateegy.com/api/v1/';
  static const String forgetPassword = '${baseUrl}auth/forgotPassword';
  static const String verifyResetCode = '${baseUrl}auth/verifyResetCode';
  static const String resetPassword = '${baseUrl}auth/resetPassword';
  static const String loginUrl = 'auth/signin';
}
