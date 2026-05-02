import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_service.g.dart';

class SecureStorageService {
  const SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> writeToken(String token) {
    return _storage.write(key: 'auth_token', value: token);
  }

  Future<String?> readToken() {
    return _storage.read(key: 'auth_token');
  }

  Future<void> clear() {
    return _storage.deleteAll();
  }
}

@riverpod
FlutterSecureStorage flutterSecureStorage(FlutterSecureStorageRef ref) {
  return const FlutterSecureStorage();
}

@riverpod
SecureStorageService secureStorageService(SecureStorageServiceRef ref) {
  return SecureStorageService(ref.watch(flutterSecureStorageProvider));
}
