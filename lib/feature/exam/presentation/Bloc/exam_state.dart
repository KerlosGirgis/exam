import '../../../../config/base_state/base_state.dart';
import '../../domain/models/exam_model.dart';

class ExamState extends BaseState<ExamResponse> {
  final int currentIndex;
  final Map<int, List<String>> answers;
  final int? score;

  ExamState({
    super.isLoading,
    super.errorMessage,
    super.data,
    this.currentIndex = 0,
    this.answers = const {},
    this.score,
  });

  factory ExamState.initial() => ExamState();

  @override
  ExamState copyWith({
    bool? isLoadingParam,
    String? errorMessageParam,
    ExamResponse? dataParam,
    int? currentIndexParam,
    Map<int, List<String>>? answersParam,
    int? scoreParam,
  }) {
    return ExamState(
      isLoading: isLoadingParam ?? isLoading,
      errorMessage: errorMessageParam ?? errorMessage,
      data: dataParam ?? data,
      currentIndex: currentIndexParam ?? currentIndex,
      answers: answersParam ?? answers,
      score: scoreParam ?? score,
    );
  }

  Question? get currentQuestion {
    if (data?.questions != null &&
        currentIndex >= 0 &&
        currentIndex < data!.questions!.length) {
      return data!.questions![currentIndex];
    }
    return null;
  }

  bool get isFirstQuestion => currentIndex == 0;
  bool get isLastQuestion =>
      data?.questions != null && currentIndex == data!.questions!.length - 1;
}
