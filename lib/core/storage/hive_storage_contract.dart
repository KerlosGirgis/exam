abstract interface class HiveStorageContract {
  Future<void> init();
  Future<void> saveData<T>(String boxName, String key, T value);
  Future<T?> getData<T>(String boxName, String key);
  Future<void> deleteData(String boxName, String key);
  Future<void> clearBox(String boxName);
  Future<Map<String, dynamic>> getAllData(String boxName);
}