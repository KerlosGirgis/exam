abstract class EndPoint {
  static const String baseUrl = 'https://exam.elevateegy.com/api/v1/';
  static const String forgetPassword = '${baseUrl}auth/forgotPassword';
  static const String verifyResetCode = '${baseUrl}auth/verifyResetCode';
  static const String resetPassword = '${baseUrl}auth/resetPassword';
  static const String loginUrl = '${baseUrl}auth/signin';
  static const String questions = '${baseUrl}questions';
  static const String getExams = '${baseUrl}exams';
  static const String getUser = 'auth/profileData';
  static const String editProfile = 'auth/editProfile';
  static const String changePassword = '${baseUrl}auth/change-password';
}
