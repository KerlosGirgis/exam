import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/auth/forget_password/domain/models/reset_password_model.dart';
import 'package:exam/feature/auth/forget_password/domain/repo/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPasswordUseCase {
  final ForgetPasswordRepoContract _repository;

  ResetPasswordUseCase(this._repository);

  Future<BaseResponse<ResetPasswordModel>> call({
    required String email,
    required String newPassword,
  }) async {
    return await _repository.resetPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}
