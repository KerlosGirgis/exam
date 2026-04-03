import '../../../../config/base_state/base_state.dart';
import '../../domain/models/exam_model.dart';

enum TimerStatus { initial, running, lowTime, finished }

class ExamState extends BaseState<ExamResponse> {
  final int currentIndex;
  final Map<int, List<String>> answers;
  final int? score;
  final int remainingSeconds;
  final int totalDurationSeconds;
  final TimerStatus timerStatus;

  ExamState({
    super.isLoading,
    super.errorMessage,
    super.data,
    this.currentIndex = 0,
    this.answers = const {},
    this.score,
    this.remainingSeconds = 0,
    this.totalDurationSeconds = 0,
    this.timerStatus = TimerStatus.initial,
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
    int? remainingSecondsParam,
    int? totalDurationSecondsParam,
    TimerStatus? timerStatusParam,
  }) {
    return ExamState(
      isLoading: isLoadingParam ?? isLoading,
      errorMessage: errorMessageParam ?? errorMessage,
      data: dataParam ?? data,
      currentIndex: currentIndexParam ?? currentIndex,
      answers: answersParam ?? answers,
      score: scoreParam ?? score,
      remainingSeconds: remainingSecondsParam ?? remainingSeconds,
      totalDurationSeconds: totalDurationSecondsParam ?? totalDurationSeconds,
      timerStatus: timerStatusParam ?? timerStatus,
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

  String get formattedTime {
    final int minutes = remainingSeconds ~/ 60;
    final int seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool get isFirstQuestion => currentIndex == 0;
  bool get isLastQuestion =>
      data?.questions != null && currentIndex == data!.questions!.length - 1;
}
