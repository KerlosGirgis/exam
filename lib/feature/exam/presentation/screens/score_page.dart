import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/feature/results/domain/models/exam_result_entity.dart';
import 'package:exam/feature/results/presentation/screens/exam_details_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int total;
  final String? examId;
  final ExamResultEntity? result;

  const ScorePage({super.key, required this.score, required this.total, this.examId, this.result});

  @override
  Widget build(BuildContext context) {
    final double percentage = total > 0 ? (score / total) * 100 : 0;
    final int incorrect = total - score;

    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.explore);
          },
          icon: const Icon(Icons.close, color: ColorManager.blackColor),
        ),
        title: const Text(
          'Exam Score',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorManager.blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Result Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Your Performance',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.greyColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Chart
                    SizedBox(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          PieChart(
                            PieChartData(
                              sectionsSpace: 4,
                              centerSpaceRadius: 70,
                              startDegreeOffset: -90,
                              sections: [
                                PieChartSectionData(
                                  color: Colors.green,
                                  value: score.toDouble(),
                                  radius: 12,
                                  showTitle: false,
                                ),
                                PieChartSectionData(
                                  color: ColorManager.errorColor,
                                  value: incorrect.toDouble(),
                                  radius: 12,
                                  showTitle: false,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${percentage.toInt()}%',
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.blackColor,
                                ),
                              ),
                              const Text(
                                'Score',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorManager.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatColumn('Correct', '$score', Colors.green),
                        _buildStatColumn('Incorrect', '$incorrect', ColorManager.errorColor),
                        _buildStatColumn('Total', '$total', ColorManager.primeColor),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Action Buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (result != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ExamDetailsScreen(result: result!),
                            ),
                          );
                        } else {
                          Navigator.of(context).pushNamed(AppRoutes.results);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primeColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Review Answers',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        if (examId != null) {
                          Navigator.of(context).pushReplacementNamed(
                            AppRoutes.exam,
                            arguments: examId,
                          );
                        } else {
                          Navigator.of(context).pushReplacementNamed(AppRoutes.explore);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: ColorManager.primeColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Start Again',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorManager.primeColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.explore),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(color: ColorManager.greyColor, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: ColorManager.greyColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
