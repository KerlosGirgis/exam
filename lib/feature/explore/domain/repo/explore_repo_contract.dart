import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/explore/domain/model/subject_entity.dart';

abstract interface class ExploreRepo {
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects();
}
