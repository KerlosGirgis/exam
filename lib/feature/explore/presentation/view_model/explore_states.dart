import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/explore/domain/model/subject_model.dart';

class ExploreStates {
  final BaseState<List<SubjectModel>>? exploreState;

  ExploreStates({this.exploreState});

  ExploreStates copyWith({BaseState<List<SubjectModel>>? exploreState}) {
    return ExploreStates(exploreState: exploreState ?? this.exploreState);
  }
}
