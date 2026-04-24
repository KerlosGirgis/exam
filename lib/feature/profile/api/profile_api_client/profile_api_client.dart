import 'package:dio/dio.dart';
import 'package:exam/core/constant/end_point.dart';
import 'package:exam/feature/profile/data/models/request/edit_profile_request.dart';
import 'package:exam/feature/profile/data/models/response/profile_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'profile_api_client.g.dart';

@injectable
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(EndPoint.getUser)
  Future<ProfileResponse> getUserProfile(@Header('token') String token);

  @PUT(EndPoint.editProfile)
  Future<ProfileResponse> editProfile(
    @Header('token') String token,
    @Body() EditProfileRequest request,
  );
}
