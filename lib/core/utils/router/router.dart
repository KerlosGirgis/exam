import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/login.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/reset_password_screen.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/verification_code_screen.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.forgetPasswordScreen:
        {
          return CupertinoPageRoute(
            builder: (context) => ForgetPasswordScreen(),
          );
        }
      case AppRoutes.verificationCodeScreen:
        {
          final email = settings.arguments as String;
          return CupertinoPageRoute(
            builder: (context) => VerificationCodeScreen(email: email),
          );
        }
      case AppRoutes.resetPasswordScreen:
        {
          final email = settings.arguments as String;
          return CupertinoPageRoute(
            builder: (context) => ResetPasswordScreen(email: email),
          );
        }
      case AppRoutes.login:
        {
          return CupertinoPageRoute(builder: (context) => Login());
        }
      default:
        return null;
    }
  }
}
