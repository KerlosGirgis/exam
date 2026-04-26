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
        backgroundColor: const Color(0xffF8F9FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: ColorManager.primeColor.withValues(alpha: 0.1),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: ColorManager.primeColor, size: 18),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          title: const Text(
            AppTextConstants.changePassword,
            style: TextStyle(
              color: ColorManager.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: const SafeArea(child: ChangePasswordBody()),
      ),
    );
  }
}
