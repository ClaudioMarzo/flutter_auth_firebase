import 'package:firebase_auth/firebase_auth.dart';

abstract class InterfaceAuthGoogle {
  Future<User?> createUserWithGoogleAccount();
  Future<void> signOutGoogle();
}