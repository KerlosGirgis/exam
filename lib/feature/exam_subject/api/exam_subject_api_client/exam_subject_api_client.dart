import 'package:dio/dio.dart';
import 'package:exam/core/constant/end_point.dart';
import 'package:exam/feature/exam_subject/data/models/response/exam_subject_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'exam_subject_api_client.g.dart';

@injectable
@RestApi()
abstract class ExamSubjectApiClient {
  @factoryMethod
  factory ExamSubjectApiClient(Dio dio) = _ExamSubjectApiClient;

  @GET(EndPoint.getExams)
  Future<ExamSubjectResponse> getExamsOnSubject({
    @Header('token') required String token,
    @Query('subject') required String subjectId,
  });
}
