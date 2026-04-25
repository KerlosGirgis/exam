import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_cubit.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_state.dart';
import 'package:exam/feature/auth/register/presentation/widgets/already_have_account.dart';
import 'package:exam/feature/auth/register/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (prev, curr) =>
          prev.registerState?.isSuccess != curr.registerState?.isSuccess ||
          prev.registerState?.errorMessage != curr.registerState?.errorMessage,
      listener: (context, state) {
        if (state.registerState?.isSuccess == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppTextConstants.signupSuccess)),
          );
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.explore,
            (route) => false,
          );
        } else if (state.registerState?.isError == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.registerState?.errorMessage ??
                    AppTextConstants.genericError,
              ),
            ),
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: const [
              RegisterForm(),
              SizedBox(height: 10),
              AlreadyHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }
}
