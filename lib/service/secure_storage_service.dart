import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();
  static const String _pinkey = 'user_pin';

  /// Save user's pin in secure storage
  /// This will be used to verify user's pin when tries to login
  /// [pin] the user's pin to be saved
 
  Future<void> savePin(String pin) async {
    await _storage.write(key: _pinkey, value: pin, aOptions: _getAndroidOptions());
  }

  Future<String?> getPin() async => await _storage.read(key: _pinkey,aOptions: _getAndroidOptions());

  Future<void> deletePin() async => await _storage.delete(key: _pinkey,aOptions: _getAndroidOptions());

  AndroidOptions _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true);
}