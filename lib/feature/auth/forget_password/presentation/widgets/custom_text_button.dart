import 'package:exam/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onTap,
    required this.title,
    this.isUnderline = true,
  });
  final void Function()? onTap;
  final String title;
  final bool? isUnderline;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ColorManager.primeColor,
          decoration: isUnderline == true ? TextDecoration.underline : null,
          decorationColor: ColorManager.primeColor,
        ),
      ),
    );
  }
}
