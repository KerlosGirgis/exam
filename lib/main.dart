import 'package:exam/config/di/di.dart';
import 'package:exam/core/theme_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/router/router.dart';
import 'package:flutter/material.dart';

import 'feature/auth/login/data/datasources/login_local_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final loginLocalDataSource = getIt<LoginLocalDataSource>();
  final token = await loginLocalDataSource.getToken();

  final String initialRoute = token != null
      ? AppRoutes.explore
      : AppRoutes.login;

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.light,
      initialRoute: AppRoutes.subjectExamScreen,
      onGenerateRoute: (settings) => RoutesManager.router(settings),
    );
  }
}
