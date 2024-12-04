import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:katyfestascatalog/features/domain/interface/interface_auth_google.dart';
import 'package:katyfestascatalog/features/domain/repositories/auth_repository_google.dart';
import 'package:katyfestascatalog/features/domain/interface/interface_auth_firebase.dart';
import 'package:katyfestascatalog/features/domain/repositories/auth_repository_firebase.dart';
import 'package:katyfestascatalog/features/presentation/authentication/authentication_controller.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Registrando FirebaseAuth e GoogleSignIn
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  getIt.registerLazySingleton<GoogleAuthProvider>(() => GoogleAuthProvider());

  // Adicionando depedência do Google na interface e repositórios
  getIt.registerLazySingleton<InterfaceAuthGoogle>(
    () => AuthRepositoryGoogle(getIt<FirebaseAuth>(), getIt<GoogleSignIn>(), getIt<GoogleAuthProvider>()),
  );

  // Adicionando depedência do FireBase na interface e repositórios
  getIt.registerLazySingleton<InterfaceAuthFireBase>(
    () => AuthRepositoryFirebase(getIt<FirebaseAuth>()),
  );

  // Adicionando depedência do InterfaceAuthFireBase
  getIt.registerSingleton<AuthenticationStateController>(
    AuthenticationStateController(getIt<InterfaceAuthFireBase>()),
  );
}