import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/storage/hive_storage.dart';
import '../../domain/use_cases/get_exam_questions_use_case.dart';
import 'exam_event.dart';
import 'exam_state.dart';

@injectable
class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final GetExamQuestionsUseCase _getExamQuestionsUseCase;
  final HiveStorage _hiveStorage;

  ExamBloc(this._getExamQuestionsUseCase, this._hiveStorage)
      : super(ExamState.initial()) {
    on<GetExamQuestionsEvent>(_onGetExamQuestions);
    on<NextQuestionEvent>(_onNextQuestion);
    on<PreviousQuestionEvent>(_onPreviousQuestion);
    on<UpdateAnswerEvent>(_onUpdateAnswer);
    on<FinishExamEvent>(_onFinishExam);
  }

  Future<void> _onGetExamQuestions(
    GetExamQuestionsEvent event,
    Emitter<ExamState> emit,
  ) async {
    emit(state.copyWith(isLoadingParam: true, errorMessageParam: null));

    final result = await _getExamQuestionsUseCase(event.examId);

    switch (result) {
      case SuccessResponse(data: var data):
        emit(state.copyWith(
          isLoadingParam: false,
          dataParam: data,
          currentIndexParam: 0,
        ));
      case ErrorResponse(errorMessage: var message):
        emit(state.copyWith(
          isLoadingParam: false,
          errorMessageParam: message,
        ));
    }
  }

  void _onNextQuestion(NextQuestionEvent event, Emitter<ExamState> emit) {
    if (state.data?.questions != null &&
        state.currentIndex < state.data!.questions!.length - 1) {
      emit(state.copyWith(currentIndexParam: state.currentIndex + 1));
    }
  }

  void _onPreviousQuestion(PreviousQuestionEvent event, Emitter<ExamState> emit) {
    if (state.currentIndex > 0) {
      emit(state.copyWith(currentIndexParam: state.currentIndex - 1));
    }
  }

  void _onUpdateAnswer(UpdateAnswerEvent event, Emitter<ExamState> emit) {
    final newAnswers = Map<int, List<String>>.from(state.answers);
    newAnswers[state.currentIndex] = event.selectedValues;
    emit(state.copyWith(answersParam: newAnswers));
  }

  Future<void> _onFinishExam(FinishExamEvent event, Emitter<ExamState> emit) async {
    final questions = state.data?.questions;
    if (questions == null) return;

    int correctAnswersCount = 0;
    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      final userAnswers = state.answers[i] ?? [];
      
      // Basic check for single choice correctly answered
      if (userAnswers.isNotEmpty && userAnswers.first == question.correct) {
        correctAnswersCount++;
      }
    }

    final examData = {
      'score': correctAnswersCount,
      'total': questions.length,
      'date': DateTime.now().toIso8601String(),
    };

    await _hiveStorage.saveData('exams_history', 'last_results', examData);
    
    emit(state.copyWith(scoreParam: correctAnswersCount));
  }
}
