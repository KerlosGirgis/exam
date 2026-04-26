import 'package:exam/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

class CustomResendRow extends StatelessWidget {
  const CustomResendRow({super.key, this.onTap});
  final void Function()? onTap;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Didn't receive code? ",
          style: TextStyle(
            color: ColorManager.greyColor,
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: const Text(
            'Resend',
            style: TextStyle(
              color: ColorManager.primeColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}