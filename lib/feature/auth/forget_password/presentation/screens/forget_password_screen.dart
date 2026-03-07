import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/validator.dart';
import 'package:exam/core/utils/widgets/custom_app_bar.dart';
import 'package:exam/core/utils/widgets/custom_elevated_button.dart';
import 'package:exam/feature/auth/forget_password/presentation/widgets/custom_header_forget_password.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomHeaderForgetPassword(
                title1: 'Forget password',
                title2: 'Please enter your email associated to your account',
              ),

              TextFormField(
                validator: FormValidator.validateEmail,
                decoration: InputDecoration(
                  hintText: 'Forget password',
                  labelText: 'Email',
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
    );
  }
}
