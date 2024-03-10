import 'package:firebase_auth/firebase_auth.dart';
import 'package:katyfestascatalog/core/providers/google_provider.dart';

enum MessageCreateGoogle { sucess, error }

enum MessageCreate { sucess, emailExist, error }

enum MessageSign { sucess, infoInvalid, error }

class FireBaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _googleProvider = GoogleProvider();

  //Deslogar da conta do Google e FireBase
  Future<void> signOutGoogle() async {
    await _googleProvider.signOut();
    await _firebaseAuth.signOut();
  }

  //Registrar novo usuário com Google
  Future<Map<MessageCreateGoogle, String?>> createUserWithGoogleAccount() async {
    AuthCredential credentialGoogle = await _googleProvider.signInWithGoogle();
    UserCredential validCredential = await _firebaseAuth.signInWithCredential(credentialGoogle);
    final User? user = validCredential.user;
    if (user != null) {
      return {MessageCreateGoogle.sucess: user.uid};
    }
    return {MessageCreateGoogle.error: null};
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
