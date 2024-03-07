import 'package:firebase_auth/firebase_auth.dart';
import 'package:katyfestascatalog/core/providers/auth_providers.dart';

enum MessageCreateGoogle { sucess, accountExist, error }

enum MessageCreate { sucess, emailExist, error }

enum MessageSign { sucess, noUser, wrongPassword, error }

class FireBaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Registrar novo usuário com Google
  Future<Map<MessageCreateGoogle, User?>> createUserWithGoogleAccount() async {
    UserCredential credentialGoogle = await AuthProviders().signInWithGoogle();
    var responseCreate = await createUserWithEmailAndPassword(credentialGoogle.user!.email!, credentialGoogle.user!.displayName!);
    if (responseCreate.entries.first.value != null) {
      return {MessageCreateGoogle.sucess: null};
    } else if (responseCreate.entries.first.key != MessageCreate.emailExist) {
      return {MessageCreateGoogle.accountExist: null};
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
          case 'user-not-found':
            return MessageSign.noUser;
          case 'wrong-password':
            return MessageSign.wrongPassword;
          default:
            return MessageSign.error;
        }
      }

      MessageSign signResult = handleFirebaseAuthException(e);
      return {signResult: null};
    }
  }
}
