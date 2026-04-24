import 'package:exam/feature/auth/register/api/apiServices/api_services.dart';
import 'package:exam/feature/auth/register/data/dataSource/register_remote_datasource_contract.dart';
import 'package:exam/feature/auth/register/data/model/register_request.dart';
import 'package:exam/feature/auth/register/data/model/register_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRemoteDatasourceContract)
class RegisterRemoteDatasourceImpl extends RegisterRemoteDatasourceContract {
  final RegisterApiService signupApiService;
  RegisterRemoteDatasourceImpl(this.signupApiService);
  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await signupApiService.register(request);
    return response;
  }
}
