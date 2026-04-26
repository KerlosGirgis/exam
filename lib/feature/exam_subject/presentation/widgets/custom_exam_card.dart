import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';
import 'package:flutter/material.dart';

class CustomExamCard extends StatelessWidget {
  const CustomExamCard({
    super.key,
    required this.examSubjectModel,
  });
  final ExamSubjectModel examSubjectModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.whiteBlueColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.subjectExamDetailsScreen,
            arguments: examSubjectModel,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ColorManager.whiteBlueColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.assignment_outlined,
                  color: ColorManager.primeColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      examSubjectModel.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: ColorManager.blackColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.help_outline, size: 14, color: ColorManager.greyColor),
                        const SizedBox(width: 4),
                        Text(
                          '${examSubjectModel.numberOfQuestions} Questions',
                          style: const TextStyle(
                            color: ColorManager.greyColor,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.timer_outlined, size: 14, color: ColorManager.greyColor),
                        const SizedBox(width: 4),
                        Text(
                          '${examSubjectModel.duration} Min',
                          style: const TextStyle(
                            color: ColorManager.greyColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: ColorManager.hintColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
