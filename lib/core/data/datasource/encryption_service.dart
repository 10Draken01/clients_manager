// data/datasources/encryption_service.dart
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  late EncryptedSharedPreferences _encryptedPrefs;

  factory EncryptionService() {
    return _instance;
  }

  EncryptionService._internal();

  Future<void> initialize() async {
    _encryptedPrefs = EncryptedSharedPreferences();
  }

  Future<void> saveString(String key, String value) async {
    print('Encrypting and saving key: $key with value: $value');
    await _encryptedPrefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    print('Decrypting and retrieving key: $key');
    return await _encryptedPrefs.getString(key);
  }

  Future<void> remove(String key) async {
    print('Removing key: $key');
    await _encryptedPrefs.remove(key);
  }

  Future<void> clear() async {
    print('Clearing all keys');
    await _encryptedPrefs.clear();
  }
}