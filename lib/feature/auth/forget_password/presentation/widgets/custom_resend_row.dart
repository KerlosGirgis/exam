import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/widgets/custom_text.dart';
import 'package:exam/feature/auth/forget_password/presentation/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class CustomResendRow extends StatelessWidget {
  const CustomResendRow({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomText(
          text: "Didn't receive code? ",
          color: ColorManager.blackColor,
          fontWeight: FontWeight.w500,
          size: 18,
        ),
        CustomTextButton(title: 'Resend', onTap: onTap),
      ],
    );
  }
}