import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:katyfestascatalog/features/service/interfaces/i_auth_firebase.dart';
import 'package:katyfestascatalog/features/service/auth_service_firebase.dart';
import 'package:katyfestascatalog/features/viewmodels/auth_view_model.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Registrando FirebaseAuth e GoogleSignIn
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  getIt.registerLazySingleton<GoogleAuthProvider>(() => GoogleAuthProvider());

  // Adicionando depedência do FireBase na interface e repositórios
  getIt.registerLazySingleton<IAuthFireBase>(
    () => AuthServiceFirebase(getIt<FirebaseAuth>(), getIt<GoogleAuthProvider>(), getIt<GoogleSignIn>(),),
  );

  // Adicionando depedência do IAuthFireBase
  getIt.registerSingleton<AuthViewModel>(
    AuthViewModel(getIt<IAuthFireBase>()),
  );
}