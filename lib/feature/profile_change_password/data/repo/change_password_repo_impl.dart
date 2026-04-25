import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/core/constant/storage_keys.dart';
import 'package:exam/core/storage/secure_storage.dart';
import 'package:exam/core/utils/error_message_mapper.dart';
import 'package:exam/feature/profile_change_password/data/data_source/change_password_remote_data_source.dart';
import 'package:exam/feature/profile_change_password/domain/model/change_password_details.dart';
import 'package:exam/feature/profile_change_password/domain/repo/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordRemoteDataSource _dataSource;
  final SecureStorage _secureStorage;

  ChangePasswordRepoImpl(this._dataSource, this._secureStorage);

  @override
  Future<BaseResponse<ChangePasswordDetails>> changePassword({
    required String oldPassword,
    required String password,
    required String rePassword,
  }) async {
    try {
      final token = await _secureStorage.getToken(key: StorageKeys.authToken);
      if (token == null || token.isEmpty) {
        return ErrorResponse<ChangePasswordDetails>(
          errorMessage: 'Authentication required. Please sign in again.',
        );
      }
      final response = await _dataSource.changePassword(
        token: token,
        oldPassword: oldPassword,
        password: password,
        rePassword: rePassword,
      );
      final details = response.toDetails();
      if (details.token != null && details.token!.isNotEmpty) {
        await _secureStorage.saveToken(
          details.token!,
          key: StorageKeys.authToken,
        );
      }
      return SuccessResponse<ChangePasswordDetails>(data: details);
    } catch (e) {
      return ErrorResponse<ChangePasswordDetails>(
        errorMessage: ErrorMessageMapper.fromException(e),
      );
    }
  }
}
