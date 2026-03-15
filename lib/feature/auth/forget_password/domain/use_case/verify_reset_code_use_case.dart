import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/auth/forget_password/domain/models/verify_reset_code_model.dart';
import 'package:exam/feature/auth/forget_password/domain/repo/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyResetCodeUseCase {
  final ForgetPasswordRepoContract _repository;

  VerifyResetCodeUseCase(this._repository);

  Future<BaseResponse<VerifyResetCodeModel>> call({
    required String resetCode,
  }) async {
    return await _repository.verifyResetCode(resetCode: resetCode);
  }
}
