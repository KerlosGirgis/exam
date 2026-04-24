import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/widgets/custom_text.dart';
import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';
import 'package:flutter/material.dart';

class CustomExamCard extends StatelessWidget {
  // final String title;
  // final int numberOfQuestions;
  // final String duration;
  // final double fromScore;
  // final double toScore;
  // final String imagePath;

  const CustomExamCard({
    super.key,
    required this.examSubjectModel,
    // required this.title,
    // required this.numberOfQuestions,
    // required this.duration,
    // required this.fromScore,
    // required this.toScore,
    // required this.imagePath,
  });
  final ExamSubjectModel examSubjectModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.subjectExamDetailsScreen,
          arguments: examSubjectModel,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: ColorManager.blackColor.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.settings_ethernet_outlined,
              size: 50,
              color: ColorManager.blackColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: examSubjectModel.title,
                        fontWeight: FontWeight.w500,
                        size: 16,
                        color: ColorManager.blackColor,
                      ),
                      Spacer(),
                      CustomText(
                        text: "${examSubjectModel.duration} Minutes",
                        color: ColorManager.primeColor,
                        fontWeight: FontWeight.w400,
                        size: 13,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: '${examSubjectModel.numberOfQuestions} Question',
                    fontWeight: FontWeight.w400,
                    size: 13,
                    color: ColorManager.hintColor,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CustomText(
                        text: 'From:',
                        fontWeight: FontWeight.w400,
                        size: 12,
                      ),
                      const SizedBox(width: 15),
                      CustomText(
                        text: 'To:',
                        fontWeight: FontWeight.w400,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
