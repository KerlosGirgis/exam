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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacementNamed(AppRoutes.navbar);
        }, icon: Icon(Icons.arrow_back_ios_new)),
        titleSpacing: 0,
        title: const Text(
          'Exam Score',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: ColorManager.blackColor,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Your Score',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorManager.blackColor,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sectionsSpace: 0,
                            centerSpaceRadius: 70,
                            startDegreeOffset: -90,
                            sections: [
                              PieChartSectionData(
                                color: ColorManager.primeColor,
                                value: score.toDouble(),
                                radius: 15,
                                showTitle: false,
                                cornerRadius: 22
                              ),
                              PieChartSectionData(
                                value: .3,
                                radius: 15,
                                showTitle: false,
                                color: Colors.white,
                              ),
                              PieChartSectionData(
                                color: ColorManager.errorColor,
                                value: incorrect.toDouble(),
                                radius: 15,
                                showTitle: false,
                                cornerRadius: 22
                              ),
                              PieChartSectionData(
                                value: .3,
                                radius: 15,
                                showTitle: false,
                                color: Colors.white,
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
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Correct",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorManager.primeColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: ColorManager.primeColor.withValues(alpha: 0.5)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.primeColor.withValues(alpha: 0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '$score',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primeColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Incorrect",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorManager.errorColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: ColorManager.errorColor.withValues(alpha: 0.5)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.errorColor.withValues(alpha: 0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '$incorrect',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.errorColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (result != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ExamDetailsScreen(result: result!),
                              ),
                            );
                          } else {
                            Navigator.of(context).pushNamed(
                              AppRoutes.results,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primeColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Show Results',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          if (examId != null) {
                            Navigator.of(context).pushReplacementNamed(
                              AppRoutes.exam,
                              arguments: examId,
                            );
                          } else {
                            Navigator.of(context).pushReplacementNamed(AppRoutes.navbar);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: ColorManager.primeColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Start Again',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorManager.primeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
