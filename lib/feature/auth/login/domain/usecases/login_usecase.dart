import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../entities/user_entity.dart';
import '../repositories/login_repository.dart';

@injectable
class LoginUseCase {
  final LoginRepository repository;
  LoginUseCase(this.repository);

  Future<BaseResponse<(User, String)>> call(
    String email,
    String password, {
    required bool rememberMe,
  }) {
    return repository.login(email, password, rememberMe: rememberMe);
  }
}
