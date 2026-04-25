import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../core/constant/app_endpoints.dart';
import '../../../explore/data/model/subject_model_dto.dart';

part 'results_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: AppEndPoints.baseUrl)
abstract class ResultsApiClient {
  @factoryMethod
  factory ResultsApiClient(Dio dio) = _ResultsApiClient;

  @GET('/subjects/{id}')
  Future<SubjectResponse> getSubjectById(
    @Header('token') String token,
    @Path('id') String id,
  );
}

@JsonSerializable()
class SubjectResponse {
  final String? message;
  @JsonKey(name: 'subject')
  final SubjectModelDto? subject;

  SubjectResponse({this.message, this.subject});

  factory SubjectResponse.fromJson(Map<String, dynamic> json) =>
      _$SubjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectResponseToJson(this);
}
