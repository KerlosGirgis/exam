import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: AppTextConstants.alreadyHaveAccount,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          TextSpan(
            text: AppTextConstants.login,
            style: const TextStyle(
              fontSize: 16,
              color: ColorManager.primeColor,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.pop(context),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
