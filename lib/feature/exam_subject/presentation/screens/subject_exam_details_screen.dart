import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/widgets/custom_app_bar.dart';
import 'package:exam/core/utils/widgets/custom_elevated_button.dart';
import 'package:exam/core/utils/widgets/custom_text.dart';
import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';
import 'package:flutter/material.dart';


class SubjectExamDetailsScreen extends StatelessWidget {
  const SubjectExamDetailsScreen({super.key, required this.modal});
  final ExamSubjectModel modal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: ''),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.settings_ethernet_outlined,
                      size: 50,
                      color: ColorManager.blackColor,
                    ),
                    SizedBox(width: 8),
                    CustomText(
                      text: "Programming",
                      fontWeight: FontWeight.w600,
                      size: 20,
                      color: ColorManager.blackColor,
                    ),
                    Spacer(),
                    CustomText(
                      text: "${modal.duration} Minutes",
                      color: ColorManager.primeColor,
                      fontWeight: FontWeight.w400,
                      size: 13,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomText(
                      text: modal.title,
                      fontWeight: FontWeight.w500,
                      size: 18,
                      color: ColorManager.blackColor,
                    ),
                    CustomText(
                      text: " | ${modal.numberOfQuestions} Question",
                      color: ColorManager.hintColor,
                      fontWeight: FontWeight.w400,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 200),
            CustomButton(title: 'Start', onPressed: () {}, isEnabled: true),
          ],
        ),
      ),
    );
  }
}
