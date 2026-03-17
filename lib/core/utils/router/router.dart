import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/feature/auth/register/presentation/screens/registerScreen.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.register:
        return CupertinoPageRoute(builder: (context) => const Registerscreen());
      //   case AppRoutes.splash:
      //     {
      //       return CupertinoPageRoute(
      //         builder: (context) => const Splash(),
      //       );
      //     }
      //   case AppRoutes.login:
      //     {
      //       return CupertinoPageRoute(
      //         builder: (context) => const LoginScreen(),
      //       );
      //     }

      //   default:
    }
    return null;
  }
}
