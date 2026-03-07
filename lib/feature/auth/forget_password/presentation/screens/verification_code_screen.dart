import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/widgets/custom_app_bar.dart';
import 'package:exam/core/utils/widgets/custom_text.dart';
import 'package:exam/feature/auth/forget_password/presentation/widgets/custom_header_forget_password.dart';
import 'package:exam/feature/auth/forget_password/presentation/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  bool hasError = false;
  final String correctPin = "123456";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Password'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomHeaderForgetPassword(
              title1: 'Email verification',
              title2: 'Please enter your code that send to your email address ',
            ),

            PinInput(
              length: 6,
              builder: (context, cells) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: cells.map((cell) {
                    return Expanded(
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: hasError
                                ? ColorManager.errorColor
                                : const Color(0xffDFE7F7),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: hasError
                              ? ColorManager.errorColor.withValues(alpha: 0.05)
                              : const Color(0xffDFE7F7),
                        ),
                        child: Center(
                          child: CustomText(
                            text: cell.character ?? '',
                            color: ColorManager.blackColor,
                            fontWeight: FontWeight.w400,
                            size: 24,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              onChanged: (pin) {
                if (hasError) {
                  setState(() => hasError = false);
                }
              },
              onCompleted: (pin) {
                if (pin != correctPin) {
                  setState(() => hasError = true);
                } else {
                  setState(() => hasError = false);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.verificationCodeScreen,
                  );
                }
              },
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(),
                    const Icon(
                      Icons.error_outline,
                      color: ColorManager.errorColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      text: "Invalid code",
                      color: ColorManager.errorColor,
                      fontWeight: FontWeight.w400,
                      size: 13,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  textAlign: TextAlign.center,
                  text: "Didn't receive code? ",
                  color: ColorManager.blackColor,
                  fontWeight: FontWeight.w500,
                  size: 18,
                ),
                CustomTextButton(
                  title: 'Resend',
                  onTap: () {
                    // logic
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
