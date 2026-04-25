import 'package:dio/dio.dart';
import 'package:exam/core/constant/app_endpoints.dart';
import 'package:exam/feature/profile_change_password/data/model/change_password_request.dart';
import 'package:exam/feature/profile_change_password/data/model/change_password_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'change_password_service.g.dart';

@injectable
@RestApi()
abstract class ChangePasswordService {
  @factoryMethod
  factory ChangePasswordService(Dio dio) = _ChangePasswordService;

  @PATCH(AppEndPoints.changePassword)
  Future<ChangePasswordResponse> changePassword(
    @Header('token') String token,
    @Body() ChangePasswordRequest request,
  );
}
