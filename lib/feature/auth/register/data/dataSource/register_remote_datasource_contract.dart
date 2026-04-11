import 'package:exam/feature/auth/register/data/model/register_request.dart';
import 'package:exam/feature/auth/register/data/model/register_response.dart';

abstract class RegisterRemoteDatasourceContract {
  Future<RegisterResponse> register(RegisterRequest request);
}
