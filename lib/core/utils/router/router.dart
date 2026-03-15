import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/di/di.dart';
import '../../../feature/auth/login/presentation/Bloc/login_bloc.dart';
import '../../../feature/auth/login/presentation/screens/login_screen.dart';
import 'app_routes.dart';

class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {
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
    return null;
  }
}
