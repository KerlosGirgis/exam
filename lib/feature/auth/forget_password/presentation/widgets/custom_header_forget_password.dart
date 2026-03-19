import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomHeaderForgetPassword extends StatelessWidget {
  const CustomHeaderForgetPassword({
    super.key,
    required this.title1,
    required this.title2,
  });
  final String title1;
  final String title2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          CustomText(
            textAlign: TextAlign.center,
            text: title1,
            color: ColorManager.blackColor,
            fontWeight: FontWeight.w500,
            size: 18,
          ),
          SizedBox(height: 16),
          CustomText(
            textAlign: TextAlign.center,
            text: title2,
            color: ColorManager.greyColor,
            fontWeight: FontWeight.w400,
            size: 18,
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
