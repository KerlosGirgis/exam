import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:flutter/material.dart' hide RadioGroup;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/widgets/radio_group.dart';
import '../Bloc/exam_bloc.dart';
import '../Bloc/exam_event.dart';
import '../Bloc/exam_state.dart';

class ExamPage extends StatefulWidget {
  final String examId;
  const ExamPage({super.key, required this.examId});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  @override
  void initState() {
    super.initState();
    context.read<ExamBloc>().add(GetExamQuestionsEvent(widget.examId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Exam',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorManager.blackColor,
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<ExamBloc, ExamState>(
            buildWhen: (previous, current) =>
                previous.remainingSeconds != current.remainingSeconds ||
                previous.timerStatus != current.timerStatus,
            builder: (context, state) {
              final bool isLowTime = state.timerStatus == TimerStatus.lowTime;
              final Color timerColor = isLowTime ? ColorManager.errorColor : Colors.green;
              
              return Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: timerColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: timerColor.withValues(alpha: 0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timer_outlined, color: timerColor, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      state.formattedTime,
                      style: TextStyle(
                        fontSize: 16,
                        color: timerColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ExamBloc, ExamState>(
            listenWhen: (previous, current) => previous.score != current.score,
            listener: (context, state) {
              if (state.score != null && state.result != null) {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.score,
                  arguments: {
                    'score': state.score!,
                    'total': state.data?.questions?.length ?? 0,
                    'result': state.result!,
                    'examId': widget.examId,
                  },
                );
              }
            },
          ),
          BlocListener<ExamBloc, ExamState>(
            listenWhen: (previous, current) =>
                previous.timerStatus != current.timerStatus,
            listener: (context, state) {
              if (state.timerStatus == TimerStatus.finished) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) => PopScope(
                    canPop: false,
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.white,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.timer_off_outlined, size: 60, color: ColorManager.errorColor),
                          const SizedBox(height: 16),
                          const Text(
                            "Time's Up!",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.blackColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "The exam session has ended. Let's see how you did!",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ColorManager.greyColor),
                          ),
                        ],
                      ),
                      actions: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primeColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              context.read<ExamBloc>().add(FinishExamEvent());
                              Navigator.of(dialogContext).pop();
                            },
                            child: const Text('View Score', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ExamBloc, ExamState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator(color: ColorManager.primeColor));
            }

            if (state.errorMessage != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 60, color: ColorManager.errorColor),
                      const SizedBox(height: 16),
                      Text(
                        state.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: ColorManager.greyColor),
                      ),
                    ],
                  ),
                ),
              );
            }

            final question = state.currentQuestion;
            if (question == null) {
              return const Center(child: Text("No questions found"));
            }

            final totalQuestions = state.data?.questions?.length ?? 0;
            final progress = totalQuestions > 0 
                ? (state.currentIndex + 1) / totalQuestions 
                : 0.0;

            return Column(
              children: [
                // Progress Bar Section
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Question ${state.currentIndex + 1}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.primeColor,
                            ),
                          ),
                          Text(
                            "of $totalQuestions",
                            style: const TextStyle(fontSize: 14, color: ColorManager.greyColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: ColorManager.whiteBlueColor,
                        color: ColorManager.primeColor,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ),
                // Question Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.question ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.blackColor,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),
                        RadioGroup<String>(
                          key: ValueKey(question.id),
                          isMultipleChoice: question.type != "single_choice",
                          initialValues: state.answers[state.currentIndex],
                          options:
                              question.answers
                                  ?.map(
                                    (a) => RadioGroupOption(
                                      value: a.key ?? "",
                                      label: a.answer ?? "",
                                    ),
                                  )
                                  .toList() ??
                              [],
                          onChanged: (values) {
                            context.read<ExamBloc>().add(UpdateAnswerEvent(values));
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                // Navigation Buttons
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (!state.isFirstQuestion)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              context.read<ExamBloc>().add(PreviousQuestionEvent());
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: ColorManager.primeColor),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              "Back",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorManager.primeColor),
                            ),
                          ),
                        ),
                      if (!state.isFirstQuestion) const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (state.isLastQuestion) {
                              context.read<ExamBloc>().add(FinishExamEvent());
                            } else {
                              context.read<ExamBloc>().add(NextQuestionEvent());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.primeColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            state.isLastQuestion ? "Finish" : "Next",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
