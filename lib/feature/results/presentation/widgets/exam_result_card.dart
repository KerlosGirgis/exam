import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/color_manager.dart';
import '../../domain/models/exam_result_entity.dart';

class ExamResultCard extends StatelessWidget {
  final ExamResultEntity result;
  final VoidCallback onTap;

  const ExamResultCard({
    super.key,
    required this.result,
    required this.onTap,
  });

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
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorManager.whiteBlueColor.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: result.subjectIcon != null
                    ? Image.network(
                  result.subjectIcon!,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.book,
                    color: ColorManager.primeColor,
                    size: 20,
                  ),
                )
                    : const Icon(
                  Icons.book,
                  color: ColorManager.primeColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.examTitle ?? result.subjectName ?? 'Unknown Exam',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: ColorManager.blackColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.quiz_outlined, size: 14, color: ColorManager.greyColor),
                        const SizedBox(width: 4),
                        Text(
                          '${result.score}/${result.total} Questions',
                          style: const TextStyle(
                            color: ColorManager.greyColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM dd, yyyy • hh:mm a').format(result.date),
                      style: const TextStyle(
                        color: ColorManager.hintColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
