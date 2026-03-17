import 'package:exam/config/di/di.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.register,
      onGenerateRoute: (settings) => RoutesManager.router(settings),
    );
  }
}
