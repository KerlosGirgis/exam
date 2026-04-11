import 'package:exam/core/constant/end_point.dart';
import 'package:exam/feature/auth/forget_password/data/models/forget_password_dto.dart';
import 'package:exam/feature/auth/forget_password/data/models/reset_password_dto.dart';
import 'package:exam/feature/auth/forget_password/data/models/verify_reset_code_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

part 'forget_password_api_client.g.dart';

@injectable
@RestApi()
abstract class ForgetPasswordApiClient {
  @factoryMethod
  factory ForgetPasswordApiClient(Dio dio) = _ForgetPasswordApiClient;

  @POST(EndPoint.forgetPassword)
  Future<ForgetPasswordDto> forgetPassword({
    @Body() required Map<String, dynamic> body,
  });

  @POST(EndPoint.verifyResetCode)
  Future<VerifyResetCodeDto> verifyResetCode({
    @Body() required Map<String, dynamic> body,
  });
  @PUT(EndPoint.resetPassword)
  Future<ResetPasswordDto> resetPassword({
    @Body() required Map<String, dynamic> body,
  });
}
