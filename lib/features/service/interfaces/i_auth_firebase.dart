import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthFireBase {
  Future<User?> createUserWithEmailAndPassword(String email, String password);
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> createUserWithGoogleAccount();
  Future<void> signOutFireBase();
}