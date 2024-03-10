import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum MessageCreateGoogle { sucess, popupClosed, error }

enum MessageCreate { sucess, emailExist, error }

enum MessageSign { sucess, infoInvalid, error }

enum MessageSingOut { sucess, error }

class FireBaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Deslogar da conta do Google e FireBase
  Future<MessageSingOut> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      return MessageSingOut.sucess;
    } catch (e) {
      return MessageSingOut.error;
    }
  }

  //Registrar novo usuário com Google
  Future<Map<MessageCreateGoogle, User?>> createUserWithGoogleAccount() async {
    GoogleAuthProvider authProvider = GoogleAuthProvider();
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithPopup(authProvider);
      return {MessageCreateGoogle.sucess: userCredential.user};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'popup-closed-by-user') {
        return {MessageCreateGoogle.popupClosed: null};
      }
      return {MessageCreateGoogle.error: null};
    }
  }

  // Registrar novo usuário
  Future<Map<MessageCreate, User?>> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return {MessageCreate.sucess: credential.user};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return {MessageCreate.emailExist: null};
      } else {
        return {MessageCreate.error: null};
      }
    }
  }

  // Fazer login de um usuário
  Future<Map<MessageSign, User?>> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return {MessageSign.sucess: credential.user};
    } on FirebaseAuthException catch (e) {
      MessageSign handleFirebaseAuthException(FirebaseAuthException e) {
        switch (e.code) {
          case 'invalid-credential':
            return MessageSign.infoInvalid;
          default:
            return MessageSign.error;
        }
      }

      MessageSign signResult = handleFirebaseAuthException(e);
      return {signResult: null};
    }
  }
}
