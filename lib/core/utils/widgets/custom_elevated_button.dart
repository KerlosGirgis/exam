import 'package:exam/core/utils/color_manager.dart';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isEnabled;
  const CustomButton({
    super.key,

    required this.title,
    required this.onPressed,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      height: 50,

      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,

        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? ColorManager.primeColor
              : ColorManager.greyColor,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),

          elevation: 0,
        ),

        child: Text(
          title,

          style: TextStyle(
            color: Colors.white,

            fontSize: 16,

            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
