import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

abstract class HiveStorage {
  Future<void> init();
  Future<void> saveData<T>(String boxName, String key, T value);
  Future<T?> getData<T>(String boxName, String key);
  Future<void> deleteData(String boxName, String key);
  Future<void> clearBox(String boxName);
}

@Injectable(as: HiveStorage)
class HiveStorageImpl implements HiveStorage {
  @override
  Future<void> init() async {
    // Initialization of Hive path should be done in main.dart if needed, 
    // but we can provide a hook here.
  }

  @override
  Future<void> saveData<T>(String boxName, String key, T value) async {
    var box = await Hive.openBox(boxName);
    await box.put(key, value);
  }

  @override
  Future<T?> getData<T>(String boxName, String key) async {
    var box = await Hive.openBox(boxName);
    return box.get(key) as T?;
  }

  @override
  Future<void> deleteData(String boxName, String key) async {
    var box = await Hive.openBox(boxName);
    await box.delete(key);
  }

  @override
  Future<void> clearBox(String boxName) async {
    var box = await Hive.openBox(boxName);
    await box.clear();
  }
}
