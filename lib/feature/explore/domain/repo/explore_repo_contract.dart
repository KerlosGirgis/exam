import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/explore/domain/model/subject_model.dart';

abstract class ExploreRepo {
  Future<BaseResponse<List<SubjectModel>>> getAllSubjects();
}
