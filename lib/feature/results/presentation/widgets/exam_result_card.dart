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
    final double percentage = result.total > 0 ? (result.score / result.total) : 0;
    final Color scoreColor = _getScoreColor(percentage);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Score indicator bar
                Container(
                  width: 6,
                  color: scoreColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Subject Icon with stylized background
                        Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: scoreColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: result.subjectIcon != null
                              ? Image.network(
                                  result.subjectIcon!,
                                  errorBuilder: (_, _, _) => Icon(
                                    Icons.assignment_outlined,
                                    color: scoreColor,
                                    size: 24,
                                  ),
                                )
                              : Icon(
                                  Icons.assignment_outlined,
                                  color: scoreColor,
                                  size: 24,
                                ),
                        ),
                        const SizedBox(width: 16),
                        // Exam Details
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today_outlined, 
                                      size: 14, color: ColorManager.greyColor.withValues(alpha: 0.7)),
                                  const SizedBox(width: 6),
                                  Text(
                                    DateFormat('MMM dd, yyyy').format(result.date),
                                    style: TextStyle(
                                      color: ColorManager.greyColor.withValues(alpha: 0.7),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${result.score} of ${result.total} correct answers',
                                style: const TextStyle(
                                  color: ColorManager.greyColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Score Percentage Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: scoreColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: scoreColor.withValues(alpha: 0.2)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${(percentage * 100).toInt()}%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: scoreColor,
                                ),
                              ),
                              Text(
                                percentage >= 0.5 ? 'Pass' : 'Fail',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: scoreColor.withValues(alpha: 0.8),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 0.8) return const Color(0xff4CAF50); // High Success - Green
    if (percentage >= 0.5) return const Color(0xffFF9800); // Average - Orange
    return const Color(0xffF44336); // Low - Red
  }
}
