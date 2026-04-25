import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/di/di.dart';
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
    return BlocProvider(
      create: (context) => getIt<ResultsBloc>()..add(LoadResultsEvent()),
      child: Scaffold(
        backgroundColor: ColorManager.whiteColor,
        appBar: AppBar(
          backgroundColor: ColorManager.whiteColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Exams History',
            style: TextStyle(
              color: ColorManager.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: BlocBuilder<ResultsBloc, ResultsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primeColor),
              );
            }

            if (state.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 60, color: ColorManager.errorColor),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage!,
                      style: const TextStyle(color: ColorManager.greyColor),
                    ),
                    TextButton(
                      onPressed: () => context.read<ResultsBloc>().add(LoadResultsEvent()),
                      child: const Text('Try Again', style: TextStyle(color: ColorManager.primeColor)),
                    ),
                  ],
                ),
              );
            }

            final results = state.results;
            if (results == null || results.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment_outlined, size: 80, color: ColorManager.hintColor.withValues(alpha: 0.5)),
                    const SizedBox(height: 16),
                    const Text(
                      'No exams taken yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorManager.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your test results will appear here',
                      style: TextStyle(color: ColorManager.hintColor),
                    ),
                  ],
                ),
              );
            }

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
              slivers: [
                ...groupedResults.entries.map((entry) {
                  return SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.primeColor,
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final result = entry.value[index];
                            return ExamResultCard(
                              result: result,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExamDetailsScreen(result: result),
                                  ),
                                );
                              },
                            );
                          },
                          childCount: entry.value.length,
                        ),
                      ),
                    ],
                  );
                }),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            );
          },
        ),
      ),
    );
  }
}
