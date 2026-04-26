import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/color_manager.dart';
import '../../domain/models/exam_result_entity.dart';
import '../bloc/results_bloc.dart';
import '../bloc/results_event.dart';
import '../bloc/results_state.dart';
import '../widgets/exam_result_card.dart';
import 'exam_details_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      body: BlocBuilder<ResultsBloc, ResultsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorManager.primeColor,
                strokeWidth: 3,
              ),
            );
          }

          if (state.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: ColorManager.errorColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.error_outline,
                          size: 48, color: ColorManager.errorColor),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ColorManager.greyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => context
                            .read<ResultsBloc>()
                            .add(LoadResultsEvent()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primeColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text(
                          'Try Again',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final results = state.results;
          if (results == null || results.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.primeColor.withValues(alpha: 0.05),
                            blurRadius: 20,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.assignment_turned_in_outlined,
                        size: 80,
                        color: ColorManager.primeColor.withValues(alpha: 0.3),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Your journey begins here!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: ColorManager.blackColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Complete your first exam to see your detailed performance breakdown and history.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorManager.greyColor.withValues(alpha: 0.7),
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Calculations for Header
          double totalPercentage = 0;
          for (var result in results) {
            totalPercentage += (result.score / result.total);
          }
          double averagePercentage = (totalPercentage / results.length) * 100;

          // Group results by subject
          final Map<String, List<ExamResultEntity>> groupedResults = {};
          for (var result in results) {
            final subject = result.subjectName ?? 'Other';
            if (!groupedResults.containsKey(subject)) {
              groupedResults[subject] = [];
            }
            groupedResults[subject]!.add(result);
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Stunning Header
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffF8F9FB),
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Exam Results',
                        style: TextStyle(
                          color: ColorManager.blackColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [ColorManager.primeColor, Color(0xff1A4BAF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.primeColor.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    value: averagePercentage / 100,
                                    strokeWidth: 8,
                                    backgroundColor:
                                        Colors.white.withValues(alpha: 0.2),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  ),
                                ),
                                Text(
                                  '${averagePercentage.toInt()}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Average Score',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _getPerformanceMessage(averagePercentage),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      '${results.length} Exams Completed',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ...groupedResults.entries.map((entry) {
                return SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                        child: Row(
                          children: [
                            Text(
                              entry.key,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: ColorManager.blackColor,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: ColorManager.primeColor.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${entry.value.length}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: ColorManager.primeColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Expanded(
                                child: Divider(indent: 16, endIndent: 0)),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final result = entry.value[index];
                            return ExamResultCard(
                              result: result,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ExamDetailsScreen(result: result),
                                  ),
                                );
                              },
                            );
                          },
                          childCount: entry.value.length,
                        ),
                      ),
                    ),
                  ],
                );
              }),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          );
        },
      ),
    );
  }

  String _getPerformanceMessage(double percentage) {
    if (percentage >= 90) return 'Excellent! 🏆';
    if (percentage >= 80) return 'Very Good! 🌟';
    if (percentage >= 70) return 'Good Job! 👍';
    if (percentage >= 50) return 'Keep it up! 💪';
    return 'Keep Practicing! 📚';
  }
}
