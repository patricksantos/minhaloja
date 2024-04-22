import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:minhaloja/infra/infra.dart';

class SecureDataSource implements StorageRepositoryInterface {
  late FlutterSecureStorage _storage;

  SecureDataSource() {
    _storage = const FlutterSecureStorage();
  }

  @override
  Future<bool?> getStorageBool(String key) async {
    var data = await _storage.read(key: key);
    return data?.toBool();
  }

  @override
  Future<dynamic> getStorageData(String key) async {
    var data = await _storage.read(key: key);

    return data != null ? jsonDecode(data) : null;
  }

  @override
  Future<int?> getStorageInt(String key) async {
    var data = await _storage.read(key: key);
    if (data == null) return null;
    return int.tryParse(data);
  }

  @override
  Future<void> removeStorage(String key) {
    return _storage.delete(key: key);
  }

  @override
  Future<void> setStorageBool(String key, bool value) {
    return _storage.write(key: key, value: value.toString());
  }

  @override
  Future<void> setStorageData(String key, Object value) {
    return _storage.write(key: key, value: jsonEncode(value));
  }

  @override
  Future<void> setStorageInt(String key, int value) {
    return _storage.write(key: key, value: value.toString());
  }

  @override
  Future<List<String>?> getStorageListData(String key) {
    // TODO: implement getStorageListData
    throw UnimplementedError();
  }

  @override
  Future<void> setStorageListData(String key, List<String> value) {
    // TODO: implement setStorageListData
    throw UnimplementedError();
  }
}
