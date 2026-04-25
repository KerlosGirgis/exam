import 'package:exam/feature/explore/data/model/subject_model_dto.dart';

abstract interface class ExploreRemoteDatasource {
  Future<List<SubjectModelDto>> getAllSubject({required String token});
}
