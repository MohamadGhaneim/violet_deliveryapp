import 'package:deliveryapp/repository/local_storage.dart';
import 'package:deliveryapp/repository/sheard_preferances.dart';
import 'package:deliveryapp/util/model/auth_result.dart';
import 'package:deliveryapp/util/services/auth/auth_service.dart';
import 'package:deliveryapp/util/services/auth/google_signin_service.dart';
import 'package:deliveryapp/util/services/firebase/notification_service.dart';

class AuthController {
  final AuthService authService;
  final LocalStorage localStorage;
  final GoogleSigninService googleSigninService;
  AuthController(this.authService, this.localStorage, this.googleSigninService);

  Future<String> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw Exception('email and password are required');
    }
    try {
      String fcmToken = await NotificationService.getFcmToken();
      final data = await authService.login(email, password, fcmToken);
      // print("AuthController Login data:  ${data.token}");
      await localStorage.addToken(data.token);
      await PrefHelper.setloggedin();
      return data.fullName;
    } catch (e) {
      throw Exception('AuthController Login error : $e');
    }
  }

  Future<String> signin() async {
    try {
      final AuthGoogleSignin user = await googleSigninService.signIn();
      // print(user.idToken);

      String fcmToken = await NotificationService.getFcmToken();
      final data = await authService.loginWithGoogle(user.idToken, fcmToken);
      await localStorage.addToken(data.token);
      await PrefHelper.setloggedin();
      return data.fullName;
    } catch (e) {
      throw Exception("AuthGoogle Exception : $e");
    }
  }

  Future<void> logout() async {
    try {
      PrefHelper.clearDelivery();
      await localStorage.deleteToken();
      await googleSigninService.signOut();
    } catch (e) {
      throw Exception("Logout error: $e");
    }
  }
}
