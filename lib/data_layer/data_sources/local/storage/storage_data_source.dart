import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart' as storage;

import 'package:quickfood/domain_layer/domain_layer.dart';

class StorageDataSource implements StorageRepositoryInterface {
  late Future<storage.SharedPreferences> _prefs;

  StorageDataSource() {
    _prefs = storage.SharedPreferences.getInstance();
  }

  @override
  Future<void> setStorageListData(String key, List<String> value) async =>
      (await _prefs).setStringList(key, value);

  @override
  Future<void> setStorageData(String key, Object value) async =>
      (await _prefs).setString(key, jsonEncode(value));

  @override
  Future<void> setStorageInt(String key, int value) async =>
      (await _prefs).setInt(key, value);

  @override
  Future<void> setStorageBool(String key, bool value) async =>
      (await _prefs).setBool(key, value);

  @override
  Future<dynamic> getStorageData(String key) async {
    var data = (await _prefs).getString(key);

    return data != null ? jsonDecode(data) : null;
  }

  @override
  Future<List<String>?> getStorageListData(String key) async {
    var data = (await _prefs).getStringList(key);
    return data;
  }

  @override
  Future<int?> getStorageInt(String key) async => (await _prefs).getInt(key);

  @override
  Future<bool?> getStorageBool(String key) async => (await _prefs).getBool(key);

  @override
  Future<void> removeStorage(String key) async => (await _prefs).remove(key);
}
