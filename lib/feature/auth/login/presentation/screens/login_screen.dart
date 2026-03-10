import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../../core/utils/widgets/custom_elevated_button.dart';
import '../Bloc/login_bloc.dart';
import '../Bloc/login_event.dart';
import '../Bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: 'Login'),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            //ToDo navigate to home screen
          }

          if (state is LoginFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16,
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          validator: FormValidator.validateEmail,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16,
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          validator: FormValidator.validatePassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (v) {}),
                              const Text(
                                "Remember Me",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  //ToDo navigate to forgot password screen
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 42)),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return CustomButton(
                              title: state is LoginLoading
                                  ? 'Loading...'
                                  : 'Login',
                              onPressed: state is LoginLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<LoginBloc>().add(
                                          LoginSubmitted(
                                            _emailController.text,
                                            _passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                              isEnabled: state is! LoginLoading,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 22)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 18),
                    ),
                    InkWell(
                      onTap: () {
                        //ToDo navigate to sign up screen
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.primeColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
