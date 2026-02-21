import 'package:deliveryapp/util/model/auth_login.dart';
import 'package:deliveryapp/util/services/path.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio dio;
  AuthService(this.dio);

  Future<AuthLogin> login(
    String email,
    String password,
    String fcmToken,
  ) async {
    try {
      final response = await dio.post(
        MyPath.login,
        data: {"email": email, "password": password, "FCM_token": fcmToken},
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final token = response.headers.value("Authorization");

        final data = {"full_name": response.data["full_name"], "token": token};
        return AuthLogin.fromJson(data);
      } else {
        throw Exception('AuthService Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Server error');
    }
  }

  // login with google
  Future<AuthLogin> loginWithGoogle(String idToken, String fcmToken) async {
    try {
      final response = await dio.post(
        MyPath.loginWithGoogle,
        data: {"id_token": idToken, "FCM_token": fcmToken},
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final token = response.headers.value("Authorization");

        final data = {"full_name": response.data["full_name"], "token": token};
        return AuthLogin.fromJson(data);
      } else {
        throw Exception('AuthService Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Server error');
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      await dio.post(MyPath.forgetPassword, data: {"email": email});
    } catch (e) {
      throw Exception('forgetPassword error: $e');
    }
  }
}
