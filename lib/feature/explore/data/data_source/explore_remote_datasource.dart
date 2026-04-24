import 'package:exam/feature/explore/data/model/subject_model_dto.dart';

abstract class ExploreRemoteDatasource {
  Future<List<SubjectModelDto>> getAllSubject();
}
