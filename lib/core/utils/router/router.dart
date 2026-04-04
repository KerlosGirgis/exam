import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/reset_password_screen.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/verification_code_screen.dart';
import 'package:exam/feature/auth/register/presentation/screens/register_screen.dart';
import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';
import 'package:exam/feature/exam_subject/presentation/screens/subject_exam_details_screen.dart';
import 'package:exam/feature/exam_subject/presentation/screens/subject_exam_screen.dart';
import 'package:exam/feature/exam_subject/presentation/view_model/cubit/exam_subject_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/di/di.dart';
import '../../../feature/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import '../../../feature/auth/forget_password/presentation/view_model/cubit/reset_password_cubit.dart';
import '../../../feature/auth/forget_password/presentation/view_model/cubit/verification_cubit.dart';
import '../../../feature/auth/login/presentation/Bloc/login_bloc.dart';
import '../../../feature/auth/login/presentation/screens/login_screen.dart';
import '../../../feature/home/presentation/screens/navbar.dart';

class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.forgetPasswordScreen:
        {
          return CupertinoPageRoute(
            builder: (context) => MultiBlocProvider(
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
              child: ForgetPasswordScreen(),
            ),
          );
        }
      case AppRoutes.verificationCodeScreen:
        {
          final email = settings.arguments as String;
          return CupertinoPageRoute(
            builder: (context) => MultiBlocProvider(
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
              child: VerificationCodeScreen(email: email),
            ),
          );
        }
      case AppRoutes.resetPasswordScreen:
        {
          final email = settings.arguments as String;
          return CupertinoPageRoute(
            builder: (context) => MultiBlocProvider(
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
              child: ResetPasswordScreen(email: email),
            ),
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
      case AppRoutes.register:
        return CupertinoPageRoute(builder: (context) => const RegisterScreen());
      case AppRoutes.navbar:
        return CupertinoPageRoute(builder: (context) => const NavBar());
      case AppRoutes.subjectExamScreen:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<ExamSubjectCubit>(),
            child: SubjectExamScreen(subjectId: '670037f6728c92b7fdf434fc'),
          ),
        );
      case AppRoutes.subjectExamDetailsScreen:
        {
          final modal = settings.arguments as ExamSubjectModel;
          return CupertinoPageRoute(
            builder: (context) => SubjectExamDetailsScreen(modal: modal),
          );
        }

      default:
        return null;
    }
  }
}
