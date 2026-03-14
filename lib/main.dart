import 'package:exam/config/di/di.dart';
import 'package:exam/core/theme_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/router/router.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/cubit/reset_password_cubit.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/cubit/verification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ForgetPasswordCubit>(
          create: (context) => getIt<ForgetPasswordCubit>(),
        ),
        BlocProvider<VerificationCubit>(
          create: (context) => getIt<VerificationCubit>(),
        ),
        BlocProvider<ResetPasswordCubit>(
          create: (context) => getIt<ResetPasswordCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.light,
        themeMode: ThemeMode.light,
        initialRoute: AppRoutes.forgetPasswordScreen,
        onGenerateRoute: (settings) => RoutesManager.router(settings),
      ),
    );
  }
}
