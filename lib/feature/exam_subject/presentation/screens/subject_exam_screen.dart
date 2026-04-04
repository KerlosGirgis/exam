import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/widgets/custom_app_bar.dart';
import 'package:exam/core/utils/widgets/custom_text.dart';
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
      appBar: buildAppBar(context, title: 'Programming'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) => cubit..getExams(subjectId),
          child: Column(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Front',
                size: 18,
                fontWeight: FontWeight.w500,
                color: ColorManager.blackColor,
              ),
              BlocBuilder<ExamSubjectCubit, ExamSubjectState>(
                builder: (BuildContext context, ExamSubjectState state) {
                  if (state.isLoading1) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.errorMessage1 != null &&
                      state.errorMessage1!.isNotEmpty) {
                    return Center(child: Text(state.errorMessage1!));
                  }
                  if (state.examSubject!.isNotEmpty) {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => CustomExamCard(
                          examSubjectModel: state.examSubject![index],
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16),
                        itemCount: state.examSubject!.length,
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
