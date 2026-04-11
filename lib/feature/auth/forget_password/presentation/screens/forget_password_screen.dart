import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/validator.dart';
import 'package:exam/core/utils/widgets/custom_app_bar.dart';
import 'package:exam/core/utils/widgets/custom_elevated_button.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/states/forget_password_state.dart';
import 'package:exam/feature/auth/forget_password/presentation/widgets/custom_header_forget_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();

    return Scaffold(
      appBar: buildAppBar(context, title: 'Password'),
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state.forgetPassword != null) {
            Navigator.pushNamed(
              context,
              AppRoutes.verificationCodeScreen,
              arguments: cubit.emailController.text,
            );
          } else if (state.errorMessage1 != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage1!)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomHeaderForgetPassword(
                    title1: 'Forget password',
                    title2:
                        'Please enter your email associated to your account',
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: cubit.emailController,
                    validator: FormValidator.validateEmail,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 48),
                  state.isLoading1
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          title: 'Continue',
                          onPressed: () {
                            cubit.forgetPassword();
                          },
                          isEnabled: true,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
