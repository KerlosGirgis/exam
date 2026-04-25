import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/feature/auth/register/data/model/register_request.dart';
import 'package:exam/feature/auth/register/domain/model/register_details.dart';
import 'package:exam/feature/auth/register/domain/repo/register_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final RegisterRepoContract registerRepo;
  RegisterUseCase(this.registerRepo);

  Future<BaseResponse<RegisterDetails>> call(RegisterRequest request) =>
      registerRepo.register(request);
}
