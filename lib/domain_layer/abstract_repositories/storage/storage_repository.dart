abstract class StorageRepositoryInterface {
  Future<void> setStorageData(String key, Object value);

  Future<void> setStorageListData(String key, List<String> value);

  Future<void> setStorageInt(String key, int value);

  Future<void> setStorageBool(String key, bool value);

  Future<List<String>?> getStorageListData(String key);

  Future<dynamic> getStorageData(String key);

  Future<int?> getStorageInt(String key);

  Future<bool?> getStorageBool(String key);

  Future<void> removeStorage(String key);
}

class StorageKeys {
  static const String auth = 'auth';
  static const String lastLoggedUser = 'last_logged_user';
  static const String cart = 'cart';
  static const String products = 'products';
}
