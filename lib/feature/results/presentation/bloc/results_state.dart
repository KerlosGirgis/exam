import '../../domain/models/exam_result_entity.dart';

class ResultsState {
  final bool isLoading;
  final String? errorMessage;
  final List<ExamResultEntity>? results;

  ResultsState({
    this.isLoading = false,
    this.errorMessage,
    this.results,
  });

  ResultsState copyWith({
    bool? isLoadingParam,
    String? errorMessageParam,
    List<ExamResultEntity>? resultsParam,
  }) {
    return ResultsState(
      isLoading: isLoadingParam ?? isLoading,
      errorMessage: errorMessageParam ?? errorMessage,
      results: resultsParam ?? results,
    );
  }
}
