import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/validator.dart';
import 'package:exam/core/utils/widgets/custom_app_bar.dart';
import 'package:exam/core/utils/widgets/custom_elevated_button.dart';
import 'package:exam/feature/auth/forget_password/presentation/widgets/custom_header_forget_password.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Password'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
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
                  validator: FormValidator.validatePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter you password',
                    labelText: 'New password',
                  ),
                ),
                SizedBox(height: 48),
                TextFormField(
                  validator: FormValidator.validatePassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    labelText: 'Confirm password',
                  ),
                ),
                SizedBox(height: 48),
                CustomButton(
                  title: 'Continue',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.forgetPasswordScreen,
                      );
                    }
                  },
                  isEnabled: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
