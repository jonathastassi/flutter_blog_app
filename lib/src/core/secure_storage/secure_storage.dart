import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<String?> read(String key);
  Future<void> store(String key, String value);
  Future<void> delete(String key);
}

class SecureStorageImpl implements SecureStorage {
  const SecureStorageImpl({
    required this.flutterSecureStorage,
  });

  final FlutterSecureStorage flutterSecureStorage;

  @override
  Future<String?> read(String key) async {
    try {
      return await flutterSecureStorage.read(key: key);
    } on PlatformException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> store(String key, String value) async {
    try {
      await flutterSecureStorage.write(key: key, value: value);
    } on PlatformException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await flutterSecureStorage.delete(key: key);
    } on PlatformException catch (_) {
      rethrow;
    }
  }
}
