import 'package:exam/config/di/di.dart';
import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/feature/profile_change_password/presentation/view_model/change_password_cubit.dart';
import 'package:exam/feature/profile_change_password/presentation/widgets/change_password_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChangePasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.whiteColor,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              AppTextConstants.resetPassword,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: SafeArea(child: ChangePasswordBody()),
      ),
    );
  }
}
