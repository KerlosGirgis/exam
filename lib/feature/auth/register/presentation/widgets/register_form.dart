import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/app_validation.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/widgets/custom_elevated_button.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_cubit.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_intent.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_state.dart';
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
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
      autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Column(
        children: [
          _buildTextField(
            controller: _usernameController,
            label: 'User Name',
            hint: 'Enter your user name',
            icon: Icons.person_outline,
            validator: (v) => AppValidators.fullNameValidator(v, AppTextConstants.enterUsernameMessage),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _firstNameController,
                  label: 'First Name',
                  hint: 'First Name',
                  validator: (v) => AppValidators.fullNameValidator(v, AppTextConstants.enterFirstNameMessage),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _lastNameController,
                  label: 'Last Name',
                  hint: 'Last Name',
                  validator: (v) => AppValidators.fullNameValidator(v, AppTextConstants.enterLastNameMessage),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.emailValidation,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _passwordController,
            label: 'Password',
            hint: 'Create a password',
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: _obscurePassword,
            onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
            validator: AppValidators.passwordValidation,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            hint: 'Confirm your password',
            icon: Icons.lock_reset_rounded,
            isPassword: true,
            obscureText: _obscureConfirmPassword,
            onToggleVisibility: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
            validator: (v) => AppValidators.passconfirmValidation(v, _passwordController),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _phoneController,
            label: 'Phone Number',
            hint: 'Enter your phone number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: AppValidators.phoneValidation,
          ),
          const SizedBox(height: 40),
          BlocBuilder<RegisterCubit, RegisterState>(
            buildWhen: (prev, curr) => prev.registerState?.isLoading != curr.registerState?.isLoading,
            builder: (context, state) {
              final isLoading = state.registerState?.isLoading ?? false;
              return SizedBox(
                width: double.infinity,
                height: 56,
                child: CustomButton(
                  title: isLoading ? 'Creating Account...' : 'Sign Up',
                  isEnabled: _isFilled && !isLoading,
                  onPressed: _onSubmit,
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(color: ColorManager.greyColor, fontSize: 15),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: ColorManager.primeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorManager.blackColor),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: ColorManager.hintColor, fontSize: 14),
              prefixIcon: icon != null ? Icon(icon, color: ColorManager.primeColor, size: 20) : null,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: ColorManager.hintColor,
                        size: 20,
                      ),
                      onPressed: onToggleVisibility,
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: ColorManager.primeColor, width: 1.5),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
