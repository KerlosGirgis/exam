import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/widgets/custom_app_bar.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/cubit/verification_cubit.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/states/verification_state.dart';
import 'package:exam/feature/auth/forget_password/presentation/widgets/custom_header_forget_password.dart';
import 'package:exam/feature/auth/forget_password/presentation/widgets/custom_invalid_code.dart';
import 'package:exam/feature/auth/forget_password/presentation/widgets/custom_pin_input.dart';
import 'package:exam/feature/auth/forget_password/presentation/widgets/custom_resend_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerificationCubit>();
    return Scaffold(
      appBar: buildAppBar(context, title: 'Password'),
      body: BlocConsumer<VerificationCubit, VerificationState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushNamed(
              context,
              AppRoutes.resetPasswordScreen,
              arguments: email,
            );
          } else if (state.hasError) {
            cubit.pinController.clear();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomHeaderForgetPassword(
                    title1: 'Email verification',
                    title2:
                        'Please enter your code that send to your email address',
                  ),
                  const SizedBox(height: 32),
                  CustomPinInput(cubit: cubit, state: state),
                  if (state.hasError) CustomInvalidCode(state: state),
                  const SizedBox(height: 24),
                  if (state.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    CustomResendRow(onTap: () {}),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
