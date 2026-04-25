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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Exam',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          BlocBuilder<ExamBloc, ExamState>(
            buildWhen: (previous, current) =>
                previous.remainingSeconds != current.remainingSeconds ||
                previous.timerStatus != current.timerStatus,
            builder: (context, state) {
              final bool isLowTime = state.timerStatus == TimerStatus.lowTime;
              return Row(
                children: [
                  Image.asset("assets/images/alarm.png"),
                  const SizedBox(width: 5),
                  Text(
                    state.formattedTime,
                    style: TextStyle(
                      fontSize: 24,
                      color: isLowTime ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
          const Padding(padding: EdgeInsets.only(right: 15)),
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
                      backgroundColor: Colors.white,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/sand_clock.png"),
                              const SizedBox(width: 10),
                              const Text(
                                "Time Out!!",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      actions: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              context.read<ExamBloc>().add(FinishExamEvent());
                              Navigator.of(dialogContext).pop();
                            },
                            child: const Text('View Score'),
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
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    state.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
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

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Question ${state.currentIndex + 1} of $totalQuestions",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[300],
                            color: Colors.blueAccent,
                            minHeight: 7,
                            borderRadius: BorderRadius.circular(23),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            question.question ?? "",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: state.isFirstQuestion
                                ? null
                                : () {
                                    context.read<ExamBloc>().add(
                                      PreviousQuestionEvent(),
                                    );
                                  },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Back",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (state.isLastQuestion) {
                                context.read<ExamBloc>().add(FinishExamEvent());
                              } else {
                                context.read<ExamBloc>().add(
                                  NextQuestionEvent(),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              state.isLastQuestion ? "Finish" : "Next",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
