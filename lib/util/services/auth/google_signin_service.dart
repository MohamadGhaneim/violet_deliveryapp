import 'package:deliveryapp/util/model/auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<AuthGoogleSignin> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception("Google sign in canceled");

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Sign in to Firebase with Google credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      // Get the Firebase ID token
      final String? firebaseIdToken = await userCredential.user?.getIdToken();

      return AuthGoogleSignin(
        email: userCredential.user?.email ?? "",
        name: userCredential.user?.displayName ?? "",
        photoUrl: userCredential.user?.photoURL ?? "",
        idToken: firebaseIdToken ?? "",
      );
    } catch (e) {
      throw Exception("GoogleSigninService : $e");
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
