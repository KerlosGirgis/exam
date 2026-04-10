import 'package:injectable/injectable.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../../domain/repositories/secure_storage_repository.dart';
import '../datasources/login_remote_data_source.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remote;
  final SecureStorageRepository storage;

  LoginRepositoryImpl(this.remote, this.storage);

  @override
  Future<(User, String)> login(String email, String password) async {
    final response = await remote.login(email, password);

    await storage.saveToken(response.token);

    return (response.user, response.token);
  }
}