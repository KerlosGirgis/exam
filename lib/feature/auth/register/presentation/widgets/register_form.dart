import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/app_validation.dart';
import 'package:exam/core/utils/widgets/custom_elevated_button.dart';
import 'package:exam/core/utils/widgets/custom_textfield.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_cubit.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_intent.dart';
import 'package:exam/feature/auth/register/presentation/widgets/register_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool autoValidate;
  const RegisterForm({
    super.key,
    required this.formKey,
    required this.autoValidate,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late RegisterCubit viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = context.read<RegisterCubit>();
    viewModel.firstNameController.addListener(_updateButtonState);
    viewModel.lastNameController.addListener(_updateButtonState);
    viewModel.usernameController.addListener(_updateButtonState);
    viewModel.emailController.addListener(_updateButtonState);
    viewModel.phoneController.addListener(_updateButtonState);
    viewModel.passwordController.addListener(_updateButtonState);
    viewModel.confirmPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() => setState(() {});

  bool get isButtonEnabled {
    final filled =
        viewModel.firstNameController.text.isNotEmpty &&
        viewModel.lastNameController.text.isNotEmpty &&
        viewModel.usernameController.text.isNotEmpty &&
        viewModel.emailController.text.isNotEmpty &&
        viewModel.phoneController.text.isNotEmpty &&
        viewModel.passwordController.text.isNotEmpty &&
        viewModel.confirmPasswordController.text.isNotEmpty;
    final loading = viewModel.state.registerState?.isLoading ?? false;
    return filled && !loading;
  }

  void _onSubmit() {
    setState(() {});
    if (widget.formKey.currentState!.validate()) {
      viewModel.doIntent(
        DoRegisterIntent(
          firstName: viewModel.firstNameController.text.trim(),
          lastName: viewModel.lastNameController.text.trim(),
          username: viewModel.usernameController.text.trim(),
          email: viewModel.emailController.text.trim(),
          phone: viewModel.phoneController.text.trim(),
          password: viewModel.passwordController.text.trim(),
          confirmPassword: viewModel.confirmPasswordController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    viewModel.firstNameController.removeListener(_updateButtonState);
    viewModel.lastNameController.removeListener(_updateButtonState);
    viewModel.usernameController.removeListener(_updateButtonState);
    viewModel.emailController.removeListener(_updateButtonState);
    viewModel.phoneController.removeListener(_updateButtonState);
    viewModel.passwordController.removeListener(_updateButtonState);
    viewModel.confirmPasswordController.removeListener(_updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RegisterCubit>().state;

    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          CustomTextfield(
            labelText: AppTextConstants.userName,
            hintText: AppTextConstants.enterUserName,
            controller: viewModel.usernameController,
            keyboardType: TextInputType.name,
            validator: (v) =>
                AppValidators.fullNameValidator(v, "Please enter your username"),
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextfield(
                  labelText: AppTextConstants.firstName,
                  hintText: AppTextConstants.enterFirstName,
                  controller: viewModel.firstNameController,
                  keyboardType: TextInputType.name,
                  validator: (v) => AppValidators.fullNameValidator(
                    v,
                    "Please enter your first name",
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextfield(
                  labelText: AppTextConstants.lastName,
                  hintText: AppTextConstants.enterLastName,
                  controller: viewModel.lastNameController,
                  keyboardType: TextInputType.name,
                  validator: (v) => AppValidators.fullNameValidator(
                    v,
                    "Please enter your last name",
                  ),
                ),
              ),
            ],
          ),
          CustomTextfield(
            labelText: AppTextConstants.email,
            hintText: AppTextConstants.enterEmail,
            controller: viewModel.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.emailValidation,
          ),
          const RegisterPasswordForm(),
          CustomTextfield(
            labelText: AppTextConstants.phoneNumber,
            hintText: AppTextConstants.enterPhoneNumber,
            controller: viewModel.phoneController,
            keyboardType: TextInputType.phone,
            validator: AppValidators.phoneValidation,
          ),
          const SizedBox(height: 20),
          CustomButton(
            title: state.registerState?.isLoading == true
                ? "Loading...."
                : AppTextConstants.signUp,
            isEnabled: isButtonEnabled,
            onPressed: isButtonEnabled ? _onSubmit : null,
          ),
        ],
      ),
    );
  }
}
