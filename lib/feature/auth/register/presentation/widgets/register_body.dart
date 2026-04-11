import 'package:exam/feature/auth/register/presentation/viewModel/register_cubit.dart';
import 'package:exam/feature/auth/register/presentation/viewModel/register_state.dart';
import 'package:exam/feature/auth/register/presentation/widgets/already_have_account.dart';
import 'package:exam/feature/auth/register/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  void _resetForm(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    cubit.clearControllers();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.registerState?.isSuccess == true) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Signup Successful!")));
          _resetForm(context);
        } else if (state.registerState?.isError == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.registerState?.errorMessage ?? "An error occurred",
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              children: [
                RegisterForm(
                  key: UniqueKey(),
                  formKey: _formKey,
                  autoValidate: _autoValidate,
                ),
                const SizedBox(height: 10),
                const AlreadyHaveAccount(),
              ],
            ),
          ),
        );
      },
    );
  }
}
