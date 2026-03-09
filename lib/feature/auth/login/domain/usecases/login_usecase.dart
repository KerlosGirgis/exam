import 'package:injectable/injectable.dart';

import '../entities/user_entity.dart';
import '../repositories/login_repository.dart';

@injectable
class LoginUseCase {
  final LoginRepository repository;
  LoginUseCase(this.repository);

  Future<(User,String)> call(String email, String password) {
    return repository.login(email, password);
  }
}
