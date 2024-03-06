import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProviders {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? getUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication getAuth = await getUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: getAuth.accessToken,
      idToken: getAuth.idToken,
    );
    UserCredential validCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return validCredential;
  }
}
