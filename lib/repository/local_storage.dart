import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final _storage = FlutterSecureStorage();

  Future<void> addToken(String token) async {
    try {
      await _storage.write(key: "auth_token", value: token);
    } catch (e) {
      throw Exception("LocalStorage , add Exception : $e");
    }
  }

  Future<String> getToken() async {
    try {
      final token = await _storage.read(key: "auth_token");
      //print("LocalStorage , getToken : $token");
      return token.toString();
    } catch (e) {
      throw Exception("LocalStorage , read Exception : $e");
    }
  }

  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: "auth_token");
    } catch (e) {
      throw Exception("LocalStorage , delete Exception : $e");
    }
  }
}
