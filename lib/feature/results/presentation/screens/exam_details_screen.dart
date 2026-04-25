import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../exam/domain/models/exam_model.dart';
import '../../domain/models/exam_result_entity.dart';

class ExamDetailsScreen extends StatelessWidget {
  final ExamResultEntity result;

  const ExamDetailsScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorManager.whiteColor,
        elevation: 0,
        title: const Text(
          'Review Answers',
          style: TextStyle(color: ColorManager.blackColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorManager.blackColor),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: result.questions.length,
              itemBuilder: (context, index) {
                final question = result.questions[index];
                final userAnswers = result.userAnswers[index] ?? [];
                final String? userAnswerKey = userAnswers.isNotEmpty ? userAnswers.first : null;

                return _buildQuestionCard(index, question, userAnswerKey);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(int index, QuestionEntity question, String? userAnswerKey) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: ColorManager.primeColor.withValues(alpha: 0.1),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: ColorManager.primeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question.question ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: ColorManager.blackColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Answers List
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: (question.answers ?? []).map<Widget>((answer) {
                final bool isUserSelected = userAnswerKey == answer.key;
                final bool isCorrect = answer.key == question.correct;
                
                Color? backgroundColor;
                Color borderColor = Colors.grey[200]!;
                IconData? icon;
                Color? contentColor = ColorManager.blackColor;

                if (isUserSelected) {
                  if (isCorrect) {
                    backgroundColor = Colors.green.withValues(alpha: 0.05);
                    borderColor = Colors.green.withValues(alpha: 0.5);
                    contentColor = Colors.green[800];
                    icon = Icons.check_circle;
                  } else {
                    backgroundColor = Colors.red.withValues(alpha: 0.05);
                    borderColor = Colors.red.withValues(alpha: 0.5);
                    contentColor = Colors.red[800];
                    icon = Icons.cancel;
                  }
                } else if (isCorrect) {
                  backgroundColor = Colors.green.withValues(alpha: 0.02);
                  borderColor = Colors.green.withValues(alpha: 0.3);
                  contentColor = Colors.green[700];
                  icon = Icons.check_circle_outline;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: borderColor),
                        ),
                        child: Text(
                          answer.key ?? '',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: contentColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          answer.answer ?? '',
                          style: TextStyle(color: contentColor, fontSize: 14),
                        ),
                      ),
                      if (icon != null) Icon(icon, color: contentColor, size: 18),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
