import 'package:injectable/injectable.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_local_data_source.dart';
import '../datasources/login_remote_data_source.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remote;
  final LoginLocalDataSource local;

  LoginRepositoryImpl(this.remote, this.local);

  @override
  Future<(User, String)> login(String email, String password) async {
    final response = await remote.login(email, password);
    await local.saveToken(response.token);
    return (response.user, response.token);
  }
}
