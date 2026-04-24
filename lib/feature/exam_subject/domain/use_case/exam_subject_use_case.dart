import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';
import 'package:exam/feature/exam_subject/domain/repo/exam_subject_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamSubjectUseCase {
  final ExamSubjectRepoContract examSubjectRepo;

  ExamSubjectUseCase(this.examSubjectRepo);
  Future<BaseResponse<List<ExamSubjectModel>>> call({String? subjectId}) async {
    return await examSubjectRepo.getExams(subjectId);
  }
}
