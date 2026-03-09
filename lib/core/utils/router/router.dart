import 'package:flutter/cupertino.dart';

import '../../../feature/auth/login/presentation/screens/login_screen.dart';
import 'app_routes.dart';

class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {
        case AppRoutes.login:
          {
            return CupertinoPageRoute(
              builder: (context) => const LoginScreen(),
            );
          }

        default:
    }
    return null;
  }
}
