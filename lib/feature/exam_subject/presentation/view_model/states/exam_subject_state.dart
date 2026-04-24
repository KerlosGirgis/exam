import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';

class ExamSubjectState {
  final BaseState<List<ExamSubjectModel>> examSubjectState;
  final bool isLoading1;
  final List<ExamSubjectModel>? examSubject;
  final String? errorMessage1;

  ExamSubjectState({
    BaseState<List<ExamSubjectModel>>? examSubjectState,
    this.isLoading1 = false,
    this.examSubject,
    this.errorMessage1,
  }) : examSubjectState =
           examSubjectState ??
           BaseState<List<ExamSubjectModel>>(isLoading: false);

  ExamSubjectState copyWith({
    BaseState<List<ExamSubjectModel>>? examSubjectStateParam,
    bool? isLoadingParam,
    List<ExamSubjectModel>? dataParam,
    String? errorMessageParam,
  }) {
    return ExamSubjectState(
      examSubjectState: examSubjectStateParam ?? examSubjectState,
      isLoading1: isLoadingParam ?? isLoading1,
      examSubject: dataParam ?? examSubject,
      errorMessage1: errorMessageParam ?? errorMessage1,
    );
  }
}
