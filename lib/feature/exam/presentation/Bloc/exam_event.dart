abstract class ExamEvent {}

class GetExamQuestionsEvent extends ExamEvent {
  final String examId;
  GetExamQuestionsEvent(this.examId);
}

class NextQuestionEvent extends ExamEvent {}

class PreviousQuestionEvent extends ExamEvent {}

class UpdateAnswerEvent extends ExamEvent {
  final List<String> selectedValues;
  UpdateAnswerEvent(this.selectedValues);
}

class FinishExamEvent extends ExamEvent {}

class TimerTickedEvent extends ExamEvent {
  final int duration;
  TimerTickedEvent(this.duration);
}
