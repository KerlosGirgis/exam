import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/reset_password_screen.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/verification_code_screen.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.forgetPasswordScreen:
        {
          return CupertinoPageRoute(builder: (context) => const ForgetPasswordScreen());
        }
      case AppRoutes.verificationCodeScreen:
        {
          return CupertinoPageRoute(builder: (context) => const VerificationCodeScreen());
        }
      case AppRoutes.resetPasswordScreen:
        {
          return CupertinoPageRoute(builder: (context) => const ResetPasswordScreen());
        }
      default:
        return null;
    }
  }
}
