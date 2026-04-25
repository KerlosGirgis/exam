import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../domain/use_cases/get_saved_exams_use_case.dart';
import 'results_event.dart';
import 'results_state.dart';

@injectable
class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  final GetSavedExamsUseCase _getSavedExamsUseCase;

  ResultsBloc(this._getSavedExamsUseCase)
      : super(ResultsState()) {
    on<LoadResultsEvent>(_onLoadResults);
  }

  Future<void> _onLoadResults(
    LoadResultsEvent event,
    Emitter<ResultsState> emit,
  ) async {
    emit(state.copyWith(isLoadingParam: true, errorMessageParam: null));

    final result = await _getSavedExamsUseCase();

    switch (result) {
      case SuccessResponse(data: var data):
        emit(state.copyWith(isLoadingParam: false, resultsParam: data));
      case ErrorResponse(errorMessage: var message):
        emit(state.copyWith(isLoadingParam: false, errorMessageParam: message));
    }
  }
}
