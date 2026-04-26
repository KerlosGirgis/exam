import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/cubit/verification_cubit.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/states/verification_state.dart';
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
      backgroundColor: const Color(0xffF8F9FB),
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
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildHeader(context),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email verification',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: ColorManager.blackColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please enter the verification code sent to your email address',
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorManager.greyColor,
                        ),
                      ),
                      const SizedBox(height: 48),
                      CustomPinInput(cubit: cubit, state: state),
                      if (state.hasError) Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: CustomInvalidCode(state: state),
                      ),
                      const SizedBox(height: 32),
                      if (state.isLoading)
                        const Center(child: CircularProgressIndicator(color: ColorManager.primeColor))
                      else
                        CustomResendRow(onTap: () {}),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorManager.primeColor, Color(0xff1A4BAF)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: CircleAvatar(radius: 120, backgroundColor: Colors.white.withValues(alpha: 0.05)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.15),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.mark_email_read_rounded, size: 60, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
