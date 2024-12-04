import 'package:flutter/foundation.dart';
import 'package:katyfestascatalog/features/domain/interface/interface_auth_firebase.dart';
import 'package:katyfestascatalog/features/presentation/authentication/authentication_state.dart';

class AuthenticationStateController {
  final InterfaceAuthFireBase _firebaseRepository;

  AuthenticationStateController(this._firebaseRepository);

  ValueNotifier<AuthenticationState> state = ValueNotifier<AuthenticationState>(const AuthenticationIdle());

  void setIdle(){
    state.value = const AuthenticationIdle();
  }

  void setLoading() {
    state.value = const AuthenticationLoading();
  }

  void setSuccess() {
    state.value = const AuthenticationSuccess();
  }

  void setError(String message) {
    state.value = AuthenticationError(message);
  }

  Future<void> loginFireBase(String email, String password)async { 
    setLoading();

    try {
      final user = await _firebaseRepository.signInWithEmailAndPassword(email, password);
      
      if (user != null) {
        setSuccess();
      } else {
        setError('Failed to login. User is null.');
      }
    } catch (e) {
      setError(e.toString());
    }
  }

}