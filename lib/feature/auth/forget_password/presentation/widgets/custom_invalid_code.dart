import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/widgets/custom_text.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/states/verification_state.dart';
import 'package:flutter/material.dart';

class CustomInvalidCode extends StatelessWidget {
  const CustomInvalidCode({super.key, required this.state});
  final VerificationState state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(
            Icons.error_outline,
            color: ColorManager.errorColor,
            size: 16,
          ),
          const SizedBox(width: 4),
          CustomText(
            text: state.errorMessage ?? "Invalid code",
            color: ColorManager.errorColor,
            fontWeight: FontWeight.w400,
            size: 13,
          ),
        ],
      ),
    );
  }
}
