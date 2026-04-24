import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';
import 'package:exam/feature/exam_subject/domain/use_case/exam_subject_use_case.dart';
import 'package:exam/feature/exam_subject/presentation/view_model/states/exam_subject_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ExamSubjectCubit extends Cubit<ExamSubjectState> {
  final ExamSubjectUseCase _examSubjectUseCase;
  ExamSubjectCubit(this._examSubjectUseCase) : super(ExamSubjectState());

  Future<void> getExams(String subjectId) async {
    emit(
      state.copyWith(
        isLoadingParam: true,
        errorMessageParam: null,
        dataParam: null,
      ),
    );
    final response = await _examSubjectUseCase(subjectId: subjectId);
    switch (response) {
      case SuccessResponse<List<ExamSubjectModel>>():
        emit(state.copyWith(isLoadingParam: false, dataParam: response.data));
        break;
      case ErrorResponse<List<ExamSubjectModel>>():
        emit(
          state.copyWith(
            isLoadingParam: false,
            errorMessageParam: response.errorMessage,
          ),
        );
        break;
    }
  }
}
