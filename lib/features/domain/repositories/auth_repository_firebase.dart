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
    } on FirebaseAuthException catch (e) {
      throw e.code; 
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  @override
  Future<void> signOutFireBase() async {
    await firebaseAuth.signOut();
  }
}