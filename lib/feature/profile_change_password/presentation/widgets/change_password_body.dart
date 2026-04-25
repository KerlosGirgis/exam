import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/app_validation.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/widgets/custom_elevated_button.dart';
import 'package:exam/core/utils/widgets/custom_textfield.dart';
import 'package:exam/feature/profile_change_password/presentation/view_model/change_password_cubit.dart';
import 'package:exam/feature/profile_change_password/presentation/view_model/change_password_intent.dart';
import 'package:exam/feature/profile_change_password/presentation/view_model/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final _formKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isFilled = false;
  bool _autoValidate = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _allFieldsFilled =>
      _currentPasswordController.text.trim().isNotEmpty &&
      _newPasswordController.text.trim().isNotEmpty &&
      _confirmPasswordController.text.trim().isNotEmpty;

  void _onFormChanged() {
    final filled = _allFieldsFilled;
    if (filled != _isFilled) {
      setState(() => _isFilled = filled);
    }
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() => _autoValidate = true);
      return;
    }

    final oldPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword == oldPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppTextConstants.newPasswordSameAsOld),
          backgroundColor: ColorManager.errorColor,
        ),
      );
      return;
    }

    context.read<ChangePasswordCubit>().add(
          ChangePasswordButtonPressed(
            oldPassword: oldPassword,
            password: newPassword,
            rePassword: confirmPassword,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (prev, curr) =>
          prev.changePasswordState?.isSuccess !=
              curr.changePasswordState?.isSuccess ||
          prev.changePasswordState?.errorMessage !=
              curr.changePasswordState?.errorMessage,
      listener: (context, state) {
        final cps = state.changePasswordState;
        if (cps?.isSuccess ?? false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                cps!.data?.message ?? AppTextConstants.passwordChangedSuccess,
              ),
              backgroundColor: ColorManager.primeColor,
            ),
          );
          Navigator.of(context).pop();
        } else if (cps?.isError ?? false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                cps!.errorMessage ?? AppTextConstants.passwordChangedError,
              ),
              backgroundColor: ColorManager.errorColor,
            ),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          onChanged: _onFormChanged,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextfield(
                labelText: AppTextConstants.currentPassword,
                hintText: AppTextConstants.enterCurrentPassword,
                controller: _currentPasswordController,
                isPassword: true,
                obscureText: true,
                validator: AppValidators.passwordValidation,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                labelText: AppTextConstants.newPassword,
                hintText: AppTextConstants.enterNewPassword,
                controller: _newPasswordController,
                isPassword: true,
                obscureText: true,
                validator: (v) {
                  final base = AppValidators.passwordValidation(v);
                  if (base != null) return base;
                  if (v != null &&
                      v.trim() ==
                          _currentPasswordController.text.trim()) {
                    return AppTextConstants.newPasswordSameAsOld;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                labelText: AppTextConstants.confirmNewPassword,
                hintText: AppTextConstants.confirmNewPassword,
                controller: _confirmPasswordController,
                isPassword: true,
                obscureText: true,
                validator: (v) => AppValidators.passconfirmValidation(
                  v,
                  _newPasswordController,
                ),
              ),
              const SizedBox(height: 32),
              BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                buildWhen: (prev, curr) =>
                    prev.changePasswordState?.isLoading !=
                    curr.changePasswordState?.isLoading,
                builder: (context, state) {
                  final isLoading =
                      state.changePasswordState?.isLoading ?? false;
                  return CustomButton(
                    title: isLoading
                        ? AppTextConstants.loading
                        : AppTextConstants.update,
                    onPressed: _onSubmit,
                    isEnabled: _isFilled && !isLoading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
