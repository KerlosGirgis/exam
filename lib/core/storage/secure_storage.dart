import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class SecureStorage {
  Future<void> saveToken(String token, {required String key});
  Future<String?> getToken({required String key});
  Future<void> deleteToken({required String key});
}

@Injectable(as: SecureStorage)
class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorageImpl(this._storage);

  @override
  Future<void> saveToken(String token, {required String key}) async {
    await _storage.write(key: key, value: token);
  }

  @override
  Future<String?> getToken({required String key}) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> deleteToken({required String key}) async {
    await _storage.delete(key: key);
  }
}
