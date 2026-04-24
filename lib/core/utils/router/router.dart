import 'package:exam/core/presentation/error_page/error_page.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/reset_password_screen.dart';
import 'package:exam/feature/auth/forget_password/presentation/screens/verification_code_screen.dart';
import 'package:exam/feature/auth/register/presentation/screens/register_screen.dart';
import 'package:exam/feature/exam/presentation/Bloc/exam_bloc.dart';
import 'package:exam/feature/exam/presentation/screens/exam_page.dart';
import 'package:exam/feature/exam/presentation/screens/score_page.dart';
import 'package:exam/feature/explore/presentation/screens/explore_screen.dart';
import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';
import 'package:exam/feature/exam_subject/presentation/screens/subject_exam_details_screen.dart';
import 'package:exam/feature/profile/presentation/screens/profile_screen.dart';
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
    try {
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
        case AppRoutes.exam:
          {
            return CupertinoPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => getIt<ExamBloc>(),
                child: const ExamPage(examId: "69d980187c82914570305e3b"),
              ),
            );
          }
        case AppRoutes.score:
          {
            final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
            return CupertinoPageRoute(
              builder: (context) => ScorePage(
                score: args['score'] as int,
                total: args['total'] as int,
              ),
            );
          }
        case AppRoutes.subjectExamDetailsScreen:
          {
            final modal = settings.arguments as ExamSubjectModel;
            return CupertinoPageRoute(
              builder: (context) => SubjectExamDetailsScreen(modal: modal),
            );
          }
        case AppRoutes.explore:
          return CupertinoPageRoute(builder: (context) => const ExplorePage());
        case AppRoutes.profile:
          return CupertinoPageRoute(builder: (context) => const ProfileScreen());
        default:
          return CupertinoPageRoute(
            builder: (context) => ErrorPage(
              errorMessage: "No route defined for ${settings.name}",
            ),
          );

      }
    } catch (e) {
      return CupertinoPageRoute(
        builder: (context) => ErrorPage(
          errorMessage: e.toString(),
        ),
      );
        }
    }
  }