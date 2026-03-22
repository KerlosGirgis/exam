import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/app_validation.dart';
import 'package:exam/core/utils/widgets/custom_textfield.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPasswordForm extends StatefulWidget {
  const RegisterPasswordForm({super.key});

  @override
  State<RegisterPasswordForm> createState() => _RegisterPasswordFormState();
}

class _RegisterPasswordFormState extends State<RegisterPasswordForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterCubit>(); 

    return Row(
      children: [
        Expanded(
          child: CustomTextfield(
            labelText: AppTextConstants.password,
            hintText: AppTextConstants.enterPassword,
            controller: viewModel.passwordController,
            obscureText: _obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
            onToggleVisibility: () =>
                setState(() => _obscurePassword = !_obscurePassword),
            validator: Validation.passwordValidation,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextfield(
            labelText: AppTextConstants.confirmPassword,
            hintText: AppTextConstants.reEnterPassword,
            controller: viewModel.confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
            onToggleVisibility: () => setState(
              () => _obscureConfirmPassword = !_obscureConfirmPassword,
            ),
            validator: (value) =>
                Validation.passconfirmValidation(value, viewModel.passwordController),
          ),
        ),
      ],
    );
  }
}
