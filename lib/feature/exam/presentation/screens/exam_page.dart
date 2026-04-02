import 'package:flutter/material.dart' hide RadioGroup;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/di/di.dart';
import '../../../../core/utils/widgets/radio_group.dart';
import '../Bloc/exam_bloc.dart';
import '../Bloc/exam_event.dart';
import '../Bloc/exam_state.dart';
import 'score_page.dart';

class ExamPage extends StatefulWidget {
  final String examId;
  const ExamPage({super.key, required this.examId});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExamBloc>()..add(GetExamQuestionsEvent(widget.examId)),
      child: const ExamBody(),
    );
  }
}

class ExamBody extends StatelessWidget {
  const ExamBody({super.key});

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
          Image.asset('assets/images/alarm.png'),
          const Text("30:00", style: TextStyle(fontSize: 26)),
          const Padding(padding: EdgeInsets.only(right: 10)),
        ],
      ),
      body: BlocListener<ExamBloc, ExamState>(
        listenWhen: (previous, current) => previous.score != current.score,
        listener: (context, state) {
          if (state.score != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ScorePage(
                  score: state.score!,
                  total: state.data?.questions?.length ?? 0,
                ),
              ),
            );
          }
        },
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
            final progress = (state.currentIndex + 1) / totalQuestions;

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
                      )
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
                    options: question.answers?.map((a) => 
                      RadioGroupOption(value: a.key ?? "", label: a.answer ?? "")
                    ).toList() ?? [],
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
                                    context.read<ExamBloc>().add(PreviousQuestionEvent());
                                  },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Back", style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        const SizedBox(width: 20),
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
