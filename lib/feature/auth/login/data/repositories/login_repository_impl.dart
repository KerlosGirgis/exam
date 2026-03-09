import 'package:injectable/injectable.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this.remote);
  final LoginRemoteDataSource remote;

  @override
  Future<(User,String)> login(String email, String password) async {
    final response = await remote.login(email, password);
    return (response.user, response.token);
  }
}