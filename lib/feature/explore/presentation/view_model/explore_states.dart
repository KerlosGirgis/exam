import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/feature/explore/domain/model/subject_entity.dart';

class ExploreStates {
  final BaseState<List<SubjectEntity>>? exploreState;

  const ExploreStates({this.exploreState});

  ExploreStates copyWith({BaseState<List<SubjectEntity>>? exploreState}) {
    return ExploreStates(exploreState: exploreState ?? this.exploreState);
  }
}
