import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/feature/exam_subject/presentation/view_model/cubit/exam_subject_cubit.dart';
import 'package:exam/feature/exam_subject/presentation/view_model/states/exam_subject_state.dart';
import 'package:exam/feature/exam_subject/presentation/widgets/custom_exam_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectExamScreen extends StatelessWidget {
  const SubjectExamScreen({super.key, required this.subjectId});
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExamSubjectCubit>();

    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorManager.whiteColor,
        elevation: 0,
        title: const Text(
          'Available Exams',
          style: TextStyle(
            color: ColorManager.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorManager.blackColor),
      ),
      body: BlocProvider(
        create: (context) => cubit..getExams(subjectId),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Select an exam to start your assessment',
                style: TextStyle(
                  color: ColorManager.greyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ExamSubjectCubit, ExamSubjectState>(
                builder: (BuildContext context, ExamSubjectState state) {
                  if (state.isLoading1) {
                    return const Center(
                      child: CircularProgressIndicator(color: ColorManager.primeColor),
                    );
                  }
                  
                  if (state.errorMessage1 != null && state.errorMessage1!.isNotEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 60, color: ColorManager.errorColor),
                            const SizedBox(height: 16),
                            Text(
                              state.errorMessage1!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: ColorManager.greyColor),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state.examSubject == null || state.examSubject!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No exams available for this subject',
                        style: TextStyle(color: ColorManager.greyColor),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemBuilder: (context, index) => CustomExamCard(
                      examSubjectModel: state.examSubject![index],
                    ),
                    itemCount: state.examSubject!.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
