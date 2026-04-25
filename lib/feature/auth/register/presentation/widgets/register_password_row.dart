import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/app_validation.dart';
import 'package:exam/core/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPasswordRow extends StatefulWidget {
  const RegisterPasswordRow({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<RegisterPasswordRow> createState() => _RegisterPasswordRowState();
}

class _RegisterPasswordRowState extends State<RegisterPasswordRow> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextfield(
            labelText: AppTextConstants.password,
            hintText: AppTextConstants.enterPassword,
            controller: widget.passwordController,
            obscureText: _obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
            onToggleVisibility: () =>
                setState(() => _obscurePassword = !_obscurePassword),
            validator: AppValidators.passwordValidation,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextfield(
            labelText: AppTextConstants.confirmPassword,
            hintText: AppTextConstants.reEnterPassword,
            controller: widget.confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
            onToggleVisibility: () => setState(
              () => _obscureConfirmPassword = !_obscureConfirmPassword,
            ),
            validator: (value) => AppValidators.passconfirmValidation(
              value,
              widget.passwordController,
            ),
          ),
        ),
      ],
    );
  }
}
