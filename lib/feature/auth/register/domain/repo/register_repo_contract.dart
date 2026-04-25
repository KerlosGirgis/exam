import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/auth/register/data/model/register_request.dart';
import 'package:exam/feature/auth/register/domain/model/register_details.dart';

abstract interface class RegisterRepoContract {
  Future<BaseResponse<RegisterDetails>> register(RegisterRequest request);
}
