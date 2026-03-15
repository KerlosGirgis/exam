import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/login.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/reset_password_screen.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/verification_code_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/di/di.dart';
import '../../../feature/auth/login/presentation/Bloc/login_bloc.dart';
import '../../../feature/auth/login/presentation/screens/login_screen.dart';
import 'app_routes.dart';

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
            return CupertinoPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => getIt<LoginBloc>(),
                child: const LoginScreen(),
              ),
            );
          }

        default:
    }
  }
}
