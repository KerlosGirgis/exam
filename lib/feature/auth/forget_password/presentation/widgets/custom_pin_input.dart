import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/widgets/custom_text.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/cubit/verification_cubit.dart';
import 'package:exam/feature/auth/forget_password/presentation/view_model/states/verification_state.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinInput extends StatelessWidget {
  const CustomPinInput({super.key, required this.cubit, required this.state});

  final VerificationCubit cubit;
  final VerificationState state;

  @override
  Widget build(BuildContext context) {
    return PinInput(
      pinController: cubit.pinController,
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
                    width: 2,
                    color: state.hasError
                        ? ColorManager.errorColor
                        : ColorManager.whiteBlueColor,
                  ),
                  borderRadius: BorderRadius.circular(10),

                  color: state.hasError
                      ? ColorManager.errorColor.withValues(alpha: 0.05)
                      : ColorManager.whiteBlueColor,
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
      onChanged: (pin) {},
      onCompleted: (pin) {
        cubit.verifyCode(pin);
      },
    );
  }
}
