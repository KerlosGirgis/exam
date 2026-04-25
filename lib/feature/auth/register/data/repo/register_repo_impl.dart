import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/core/utils/error_message_mapper.dart';
import 'package:exam/feature/auth/login/data/datasources/login_local_data_source.dart';
import 'package:exam/feature/auth/register/data/dataSource/register_remote_datasource_contract.dart';
import 'package:exam/feature/auth/register/data/model/register_request.dart';
import 'package:exam/feature/auth/register/domain/model/register_details.dart';
import 'package:exam/feature/auth/register/domain/repo/register_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRepoContract)
class RegisterRepoImpl implements RegisterRepoContract {
  final RegisterRemoteDatasourceContract _remoteDatasource;
  final LoginLocalDataSource _localDataSource;
  RegisterRepoImpl(this._remoteDatasource, this._localDataSource);

  @override
  Future<BaseResponse<RegisterDetails>> register(RegisterRequest request) async {
    try {
      final result = await _remoteDatasource.register(request);
      final domain = result.toDomain();
      if (domain.token.isNotEmpty) {
        await _localDataSource.saveToken(domain.token);
      }
      return SuccessResponse(data: domain);
    } catch (e) {
      return ErrorResponse<RegisterDetails>(
        errorMessage: ErrorMessageMapper.fromException(e),
      );
    }
  }
}
