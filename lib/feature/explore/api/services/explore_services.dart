import 'package:dio/dio.dart';
import 'package:exam/core/constant/app_endpoints.dart';
import 'package:exam/feature/explore/data/model/subject_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'explore_services.g.dart';

@injectable
@RestApi()
abstract class ExploreService {
  @factoryMethod
  factory ExploreService(Dio dio) = _ExploreService;

  @GET(AppEndPoints.subjectEndpoint)
  Future<SubjectsResponseModel> getAllSubjects(@Header("token") String token);
}
