import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constant/end_point.dart';
import '../../data/models/exam_dto.dart';

part 'exam_api_client.g.dart';

@injectable
@RestApi()
abstract class ExamApiClient {
  @factoryMethod
  factory ExamApiClient(Dio dio) = _ExamApiClient;

  @GET(EndPoint.questions)
  Future<ExamResponseDto> getExamQuestions(
    @Header('token') String token,
    @Query('exam') String examId,
  );
}
