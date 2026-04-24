import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/storage/secure_storage.dart';
import 'package:exam/core/utils/app_validation.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/widgets/custom_elevated_button.dart';
import 'package:exam/core/utils/widgets/custom_textfield.dart';
import 'package:exam/feature/profile_change_password/presentation/view_model/change_password_cubit.dart';
import 'package:exam/feature/profile_change_password/presentation/view_model/change_password_intent.dart';
import 'package:exam/feature/profile_change_password/presentation/view_model/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  late ChangePasswordCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = context.read<ChangePasswordCubit>();
    _cubit.currentPasswordController.addListener(_updateButtonState);
    _cubit.newPasswordController.addListener(_updateButtonState);
    _cubit.confirmPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() => setState(() {});

  bool get _isButtonEnabled {
    return _cubit.currentPasswordController.text.isNotEmpty &&
        _cubit.newPasswordController.text.isNotEmpty &&
        _cubit.confirmPasswordController.text.isNotEmpty;
  }

  void _onChangePasswordPressed() async {
    setState(() => _autoValidate = true);

    if (_formKey.currentState!.validate()) {
      final secureStorage = GetIt.I<SecureStorage>();
      final token = await secureStorage.getToken(key: 'auth_token');

      if (token == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Authentication required'),
              backgroundColor: ColorManager.errorColor,
            ),
          );
        }
        return;
      }

      if (mounted) {
        _cubit.add(ChangePasswordButtonPressed(
          token: token,
          oldPassword: _cubit.currentPasswordController.text.trim(),
          password: _cubit.newPasswordController.text.trim(),
          rePassword: _cubit.confirmPasswordController.text.trim(),
        ));
      }
    }
  }

  @override
  void dispose() {
    _cubit.currentPasswordController.removeListener(_updateButtonState);
    _cubit.newPasswordController.removeListener(_updateButtonState);
    _cubit.confirmPasswordController.removeListener(_updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        final changePasswordState = state.changePasswordState;

        if (changePasswordState?.isSuccess ?? false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                changePasswordState!.data?.message ??
                    AppTextConstants.passwordChangedSuccess,
              ),
              backgroundColor: ColorManager.primeColor,
            ),
          );
          _cubit.clearControllers();
          Navigator.pop(context);
        } else if (changePasswordState?.isError ?? false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(changePasswordState!.errorMessage!),
              backgroundColor: ColorManager.errorColor,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.changePasswordState?.isLoading ?? false;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextfield(
                  labelText: AppTextConstants.currentPassword,
                  hintText: AppTextConstants.enterCurrentPassword,
                  controller: _cubit.currentPasswordController,
                  isPassword: true,
                  obscureText: true,
                  validator: (v) => Validation.passwordValidation(v),
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  labelText: AppTextConstants.newPassword,
                  hintText: AppTextConstants.enterNewPassword,
                  controller: _cubit.newPasswordController,
                  isPassword: true,
                  obscureText: true,
                  validator: (v) => Validation.passwordValidation(v),
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  labelText: AppTextConstants.confirmNewPassword,
                  hintText: AppTextConstants.confirmNewPassword,
                  controller: _cubit.confirmPasswordController,
                  isPassword: true,
                  obscureText: true,
                  validator: (v) => Validation.passconfirmValidation(
                    v,
                    _cubit.newPasswordController,
                  ),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  title: isLoading ? 'Loading...' : AppTextConstants.update,
                  onPressed: _onChangePasswordPressed,
                  isEnabled: _isButtonEnabled && !isLoading,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
