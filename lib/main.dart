import 'dart:io';

import 'package:exam/config/di/di.dart';
import 'package:exam/core/theme_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'feature/auth/login/data/datasources/login_local_data_source.dart';
import 'core/storage/hive_storage_contract.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String dbPath = '${appDocDir.path}/db';
  final Directory dbDir = Directory(dbPath);
  if (!await dbDir.exists()) {
    await dbDir.create(recursive: true);
  }
  Hive.init(dbPath);

  configureDependencies();
  
  await getIt<HiveStorageContract>().init();
  
  final loginLocalDataSource = getIt<LoginLocalDataSource>();
  final token = await loginLocalDataSource.getToken();
  
  final String initialRoute = token != null ? AppRoutes.navbar : AppRoutes.login;
  
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
      initialRoute: AppRoutes.exam,
      onGenerateRoute: (settings) => RoutesManager.router(settings),
    );
  }
}
