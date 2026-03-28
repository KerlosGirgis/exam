import 'package:injectable/injectable.dart';
import '../../../../../core/storage/secure_storage.dart';

abstract class LoginLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}

@Injectable(as: LoginLocalDataSource)
class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SecureStorage _tokenStorage;
  static const String _tokenKey = 'auth_token';

  LoginLocalDataSourceImpl(this._tokenStorage);

  @override
  Future<void> saveToken(String token) async {
    await _tokenStorage.saveToken(token, key: _tokenKey);
  }

  @override
  Future<String?> getToken() async {
    return await _tokenStorage.getToken(key: _tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await _tokenStorage.deleteToken(key: _tokenKey);
  }
}
