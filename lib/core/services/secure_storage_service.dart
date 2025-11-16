import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }

  Future<void> saveLastInteractionTime(DateTime time) async {
    await _storage.write(key: 'last_interaction', value: time.toIso8601String());
  }

  Future<DateTime?> getLastInteractionTime() async {
    final timeString = await _storage.read(key: 'last_interaction');
    if (timeString == null) {
      return null;
    }
    return DateTime.parse(timeString);
  }
}