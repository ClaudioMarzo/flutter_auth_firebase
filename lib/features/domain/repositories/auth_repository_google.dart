import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:katyfestascatalog/features/domain/interface/interface_auth_google.dart';

class AuthRepositoryGoogle implements InterfaceAuthGoogle{
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final GoogleAuthProvider authProvider;

  AuthRepositoryGoogle(this.firebaseAuth, this.googleSignIn, this.authProvider);

  @override
  Future<User?> createUserWithGoogleAccount() async {
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithPopup(authProvider);
      return  userCredential.user;
    } on FirebaseAuthException {
      return null;
    }
  }

  @override
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }

}