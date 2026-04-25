import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import 'hive_storage_contract.dart';

@Injectable(as: HiveStorageContract)
class HiveStorageImpl implements HiveStorageContract {
  @override
  Future<void> init() async {
    await Hive.openBox('exams_history');
  }

  @override
  Future<void> saveData<T>(String boxName, String key, T value) async {
    var box = Hive.box(boxName);
    await box.put(key, value);
  }

  @override
  Future<T?> getData<T>(String boxName, String key) async {
    var box = Hive.box(boxName);
    return box.get(key) as T?;
  }

  @override
  Future<void> deleteData(String boxName, String key) async {
    var box = Hive.box(boxName);
    await box.delete(key);
  }

  @override
  Future<void> clearBox(String boxName) async {
    var box = Hive.box(boxName);
    await box.clear();
  }

  @override
  Future<Map<String, dynamic>> getAllData(String boxName) async {
    var box = Hive.box(boxName);
    return Map<String, dynamic>.from(box.toMap());
  }
}
