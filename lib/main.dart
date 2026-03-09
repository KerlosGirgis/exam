import 'package:exam/core/theme_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeManager.light,
      initialRoute: AppRoutes.login,
      onGenerateRoute: (settings) => RoutesManager.router(settings),
      home: Text('Home'),
    );
  }
}
