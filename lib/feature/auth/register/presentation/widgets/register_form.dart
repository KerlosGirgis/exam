import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/app_validation.dart';
import 'package:exam/core/utils/widgets/custom_elevated_button.dart';
import 'package:exam/core/utils/widgets/custom_textfield.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_cubit.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_intent.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_state.dart';
import 'package:exam/feature/auth/register/presentation/widgets/register_password_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isFilled = false;
  bool _autoValidate = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _allFieldsFilled =>
      _usernameController.text.trim().isNotEmpty &&
      _firstNameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
      _phoneController.text.trim().isNotEmpty &&
      _passwordController.text.trim().isNotEmpty &&
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

    context.read<RegisterCubit>().doIntent(
          DoRegisterIntent(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            username: _usernameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            password: _passwordController.text.trim(),
            confirmPassword: _confirmPasswordController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: _onFormChanged,
      autovalidateMode: _autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          CustomTextfield(
            labelText: AppTextConstants.userName,
            hintText: AppTextConstants.enterUserName,
            controller: _usernameController,
            keyboardType: TextInputType.name,
            validator: (v) => AppValidators.fullNameValidator(
              v,
              AppTextConstants.enterUsernameMessage,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextfield(
                  labelText: AppTextConstants.firstName,
                  hintText: AppTextConstants.enterFirstName,
                  controller: _firstNameController,
                  keyboardType: TextInputType.name,
                  validator: (v) => AppValidators.fullNameValidator(
                    v,
                    AppTextConstants.enterFirstNameMessage,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextfield(
                  labelText: AppTextConstants.lastName,
                  hintText: AppTextConstants.enterLastName,
                  controller: _lastNameController,
                  keyboardType: TextInputType.name,
                  validator: (v) => AppValidators.fullNameValidator(
                    v,
                    AppTextConstants.enterLastNameMessage,
                  ),
                ),
              ),
            ],
          ),
          CustomTextfield(
            labelText: AppTextConstants.email,
            hintText: AppTextConstants.enterEmail,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.emailValidation,
          ),
          RegisterPasswordRow(
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
          ),
          CustomTextfield(
            labelText: AppTextConstants.phoneNumber,
            hintText: AppTextConstants.enterPhoneNumber,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: AppValidators.phoneValidation,
          ),
          const SizedBox(height: 20),
          BlocBuilder<RegisterCubit, RegisterState>(
            buildWhen: (prev, curr) =>
                prev.registerState?.isLoading !=
                curr.registerState?.isLoading,
            builder: (context, state) {
              final isLoading = state.registerState?.isLoading ?? false;
              return CustomButton(
                title: isLoading
                    ? AppTextConstants.loading
                    : AppTextConstants.signUp,
                isEnabled: _isFilled && !isLoading,
                onPressed: _onSubmit,
              );
            },
          ),
        ],
      ),
    );
  }
}
