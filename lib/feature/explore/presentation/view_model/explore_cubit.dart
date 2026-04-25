import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/explore/domain/model/subject_entity.dart';
import 'package:exam/feature/explore/domain/usecase/subjects_use_case.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_intent.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreCubit extends Cubit<ExploreStates> {
  final SubjectsUseCase _subjectsUsecase;

  ExploreCubit(this._subjectsUsecase) : super(const ExploreStates());

  List<SubjectEntity> allSubjects = [];

  void doIntent(ExploreIntent intent) {
    switch (intent) {
      case LoadSubjectsIntent():
        _loadSubjectsData();
        break;
      case FilterSubjectsIntent():
        _filterSubjects(intent.subject);
        break;
    }
  }

  Future<void> _loadSubjectsData() async {
    emit(state.copyWith(exploreState: BaseState(isLoading: true)));

    final result = await _subjectsUsecase.call();

    switch (result) {
      case SuccessResponse():
        allSubjects = result.data;
        emit(state.copyWith(exploreState: BaseState(data: allSubjects)));
        break;
      case ErrorResponse():
        emit(
          state.copyWith(
            exploreState: BaseState(errorMessage: result.errorMessage),
          ),
        );
        break;
    }
  }

  void _filterSubjects(String keyword) {
    if (keyword.isEmpty) {
      emit(state.copyWith(exploreState: BaseState(data: allSubjects)));
      return;
    }
    final filtered = allSubjects
        .where(
          (subject) =>
              subject.name != null &&
              subject.name!.toLowerCase().contains(keyword.toLowerCase()),
        )
        .toList();
    emit(state.copyWith(exploreState: BaseState(data: filtered)));
  }
}
