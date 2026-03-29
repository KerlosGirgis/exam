import 'package:exam/config/di/di.dart';
import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/widgets/custom_app_bar.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_cubit.dart';
import 'package:exam/feature/auth/register/presentation/widgets/register_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<RegisterCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(
          context,
          title: AppTextConstants.register,
          showBackButton: true,
        ),
        body: RegisterBody(),
      ),
    );
  }
}
