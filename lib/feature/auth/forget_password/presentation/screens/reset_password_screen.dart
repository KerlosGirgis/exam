import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/validator.dart';
import 'package:exam/core/utils/widgets/custom_app_bar.dart';
import 'package:exam/core/utils/widgets/custom_elevated_button.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/cubit/reset_password_cubit.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/states/reset_password_state.dart';
import 'package:exam/feature/auth/forget_password/presentation/widgets/custom_header_forget_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResetPasswordCubit>();
    return Scaffold(
      appBar: buildAppBar(context, title: 'Password'),
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Password Reset Successfully!"),
                backgroundColor: ColorManager.primeColor,
                duration: Duration(seconds: 1),
              ),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomHeaderForgetPassword(
                      title1: 'Reset password',
                      title2:
                          'Password must not be empty and must contain 6 characters with upper case letter and one number at least ',
                    ),
                    TextFormField(
                      controller: cubit.passwordController,
                      obscureText: state.isObscure,
                      validator: FormValidator.validatePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter you password',
                        labelText: 'New password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => cubit.changeObscureText(),
                        ),
                      ),
                    ),
                    SizedBox(height: 48),
                    TextFormField(
                      controller: cubit.confirmPasswordController,
                      obscureText: state.isObscure,
                      validator: FormValidator.validatePassword,
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
                        labelText: 'Confirm password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => cubit.changeObscureText(),
                        ),
                      ),
                    ),
                    SizedBox(height: 48),
                    state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title: 'Continue',
                            onPressed: () {
                              cubit.resetPassword(
                                email,
                                cubit.passwordController.text,
                              );
                            },
                            isEnabled: true,
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
