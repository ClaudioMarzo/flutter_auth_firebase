import 'package:firebase_auth/firebase_auth.dart';
import 'package:katyfestascatalog/features/domain/interface/interface_auth_firebase.dart';

class AuthRepositoryFirebase implements InterfaceAuthFireBase{
  final FirebaseAuth firebaseAuth;

  AuthRepositoryFirebase(this.firebaseAuth);
  
  @override
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e){
      return null;
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found for that email.');
        case 'wrong-password':
          throw Exception('Wrong password provided for that user.');
        default:
          throw Exception('Authentication error: ${e.message}');
      }
    }
  }

  @override
  Future<void> signOutFireBase() async {
    await firebaseAuth.signOut();
  }
}