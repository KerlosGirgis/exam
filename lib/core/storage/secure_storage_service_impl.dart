import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'secure_storage_service.dart';

@LazySingleton(as: SecureStorageService)
class SecureStorageServiceImpl implements SecureStorageService {
  final FlutterSecureStorage storage;

  SecureStorageServiceImpl(this.storage);

  @override
  Future<void> write({
    required String key,
    required String value,
  }) async {
    await storage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}