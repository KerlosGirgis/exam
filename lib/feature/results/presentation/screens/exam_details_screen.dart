import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../exam/domain/models/exam_model.dart';
import '../../domain/models/exam_result_entity.dart';

class ExamDetailsScreen extends StatelessWidget {
  final ExamResultEntity result;

  const ExamDetailsScreen({super.key, required this.result});
  
  @override
  Widget build(BuildContext context) {
    final double percentage = result.total > 0 ? (result.score / result.total) * 100 : 0;
    
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Stunning Modern Header
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            stretch: true,
            backgroundColor: ColorManager.primeColor,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.1),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient Background
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [ColorManager.primeColor, Color(0xff1A4BAF)],
                      ),
                    ),
                  ),
                  // Abstract decorative circles
                  Positioned(
                    top: -40,
                    right: -40,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 80, 24, 16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24, width: 2),
                          ),
                          child: Text(
                            '${percentage.toInt()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                result.examTitle ?? 'Review Answers',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  letterSpacing: -0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Score: ${result.score}/${result.total}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '•  ${result.subjectName ?? ""}',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.5),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Questions List
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final question = result.questions[index];
                  final userAnswers = result.userAnswers[index] ?? [];
                  final String? userAnswerKey = userAnswers.isNotEmpty ? userAnswers.first : null;

                  return _buildQuestionCard(index, question, userAnswerKey);
                },
                childCount: result.questions.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(int index, QuestionEntity question, String? userAnswerKey) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xffFBFBFC),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              border: Border(bottom: BorderSide(color: Colors.black.withValues(alpha: 0.05))),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorManager.primeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: ColorManager.primeColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    question.question ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: ColorManager.blackColor,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Answers List
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: (question.answers ?? []).map<Widget>((answer) {
                final bool isUserSelected = userAnswerKey == answer.key;
                final bool isCorrect = answer.key == question.correct;
                
                Color backgroundColor = Colors.white;
                Color borderColor = ColorManager.whiteBlueColor;
                IconData? icon;
                Color contentColor = ColorManager.blackColor;
                FontWeight fontWeight = FontWeight.w600;

                if (isUserSelected) {
                  if (isCorrect) {
                    backgroundColor = const Color(0xffE8F5E9);
                    borderColor = const Color(0xff4CAF50).withValues(alpha: 0.3);
                    contentColor = const Color(0xff2E7D32);
                    icon = Icons.check_circle;
                  } else {
                    backgroundColor = const Color(0xffFFEBEE);
                    borderColor = const Color(0xffEF5350).withValues(alpha: 0.3);
                    contentColor = const Color(0xffC62828);
                    icon = Icons.cancel;
                  }
                } else if (isCorrect) {
                  backgroundColor = const Color(0xffE8F5E9).withValues(alpha: 0.5);
                  borderColor = const Color(0xff4CAF50).withValues(alpha: 0.2);
                  contentColor = const Color(0xff2E7D32);
                  icon = Icons.check_circle_outline;
                }

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor, width: isUserSelected ? 2 : 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isUserSelected || isCorrect ? Colors.transparent : Colors.grey[100],
                          shape: BoxShape.circle,
                          border: Border.all(color: borderColor),
                        ),
                        child: Text(
                          answer.key ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: contentColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          answer.answer ?? '',
                          style: TextStyle(
                            color: contentColor,
                            fontSize: 15,
                            fontWeight: fontWeight,
                          ),
                        ),
                      ),
                      if (icon != null) Icon(icon, color: contentColor, size: 22),
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
