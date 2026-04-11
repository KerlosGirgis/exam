import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/auth/forget_password/domain/models/forget_password_model.dart';
import 'package:exam/feature/auth/forget_password/domain/repo/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUseCase {
  ForgetPasswordUseCase(this.forgetPasswordRepo);
  final ForgetPasswordRepoContract forgetPasswordRepo;

  Future<BaseResponse<ForgetPasswordModel>> call({String? email}) async {
    return await forgetPasswordRepo.forgetPassword(email);
  }
}
