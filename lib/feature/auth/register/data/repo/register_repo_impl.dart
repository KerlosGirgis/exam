import 'package:dio/dio.dart';
import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/auth/login/data/datasources/login_local_data_source.dart';
import 'package:exam/feature/auth/register/data/dataSource/register_remote_datasource_contract.dart';
import 'package:exam/feature/auth/register/data/model/register_request.dart';
import 'package:exam/feature/auth/register/domain/model/user_model.dart';
import 'package:exam/feature/auth/register/domain/repo/register_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRepoContract)
class RegisterRepoImpl extends RegisterRepoContract {
  final RegisterRemoteDatasourceContract _remoteDatasource;
  final LoginLocalDataSource _localDataSource;
  RegisterRepoImpl(this._remoteDatasource, this._localDataSource);

  @override
  Future<BaseResponse<RegisterModel>> register(RegisterRequest request) async {
    try {
      final result = await _remoteDatasource.register(request);
      final domain = result.toDomain();
      if (domain.token.isNotEmpty) {
        await _localDataSource.saveToken(domain.token);
      }
      return SuccessResponse(data: domain);
    } on DioException catch (e) {
      String message = 'An error occurred';
      if (e.response != null) {
        message = '${e.response?.data}';
      } else if (e.type == DioExceptionType.connectionTimeout) {
        message = 'Connection timeout';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        message = 'Receive timeout';
      } else if (e.type == DioExceptionType.connectionError) {
        message = 'Connection error - check your internet';
      }
      return ErrorResponse<RegisterModel>(errorMessage: message);
    } catch (e) {
      return ErrorResponse<RegisterModel>(errorMessage: e.toString());
    }
  }
}
