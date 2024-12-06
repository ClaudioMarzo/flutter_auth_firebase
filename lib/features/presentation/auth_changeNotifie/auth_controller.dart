import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:katyfestascatalog/core/services/firebase_service.dart';
import 'package:katyfestascatalog/features/models/auth_request_model.dart';

enum RegisterGoogleState { idle, loading, success, popupClosed, error }

enum RegisterFireBaseState { idle, loading, success, accountExit, error }

enum InputState { idle, validInput, invalidEmail, empty }

enum LoginState { idle, loading, success, infoInvalid, error }

class AuthController extends ChangeNotifier {
  final FireBaseService client;
  LoginState login = LoginState.idle;
  InputState inputs = InputState.idle;
  RegisterFireBaseState register = RegisterFireBaseState.idle;
  RegisterGoogleState google = RegisterGoogleState.idle;
  UserModel authRequest = UserModel('', '');

  AuthController(this.client);

  void idleAllState() {
    login = LoginState.idle;
    inputs = InputState.idle;
    register = RegisterFireBaseState.idle;
    google = RegisterGoogleState.idle;
    authRequest = UserModel('', '');
    notifyListeners();
  }

  Future<void> loginAccountAction() async {
    login = LoginState.loading;
    register = RegisterFireBaseState.idle;
    google = RegisterGoogleState.idle;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    inputs = _validatingEntries(authRequest.email, authRequest.password);
    notifyListeners();
    if (inputs == InputState.validInput) {
      var response = await client.signInWithEmailAndPassword(authRequest.email, authRequest.password);
      if (response.entries.first.value != null) {
        login = LoginState.success;
        notifyListeners();
      } else if (response.entries.first.key == MessageSign.infoInvalid) {
        inputs = InputState.idle;
        login = LoginState.infoInvalid;
        notifyListeners();
      } else {
        inputs = InputState.idle;
        login = LoginState.error;
        notifyListeners();
      }
    } else {
      login = LoginState.idle;
      inputs = InputState.idle;
      notifyListeners();
    }
  }

  Future<void> createAccountAction() async {
    register = RegisterFireBaseState.loading;
    login = LoginState.idle;
    google = RegisterGoogleState.idle;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    inputs = _validatingEntries(authRequest.email, authRequest.password);
    notifyListeners();
    if (inputs == InputState.validInput) {
      var response = await client.createUserWithEmailAndPassword(authRequest.email, authRequest.password);
      if (response.entries.first.value != null) {
        register = RegisterFireBaseState.success;
        inputs = InputState.idle;
        notifyListeners();
      } else if (response.entries.first.key == MessageCreate.emailExist) {
        register = RegisterFireBaseState.accountExit;
        inputs = InputState.idle;
        notifyListeners();
      } else {
        register = RegisterFireBaseState.error;
        inputs = InputState.idle;
        notifyListeners();
      }
    } else {
      register = RegisterFireBaseState.idle;
      inputs = InputState.idle;
      notifyListeners();
    }
  }

  Future<void> accountGoogleAction() async {
    login = LoginState.idle;
    register = RegisterFireBaseState.idle;
    google = RegisterGoogleState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    var response = await client.createUserWithGoogleAccount();
    if (response.entries.first.key == MessageCreateGoogle.sucess) {
      google = RegisterGoogleState.success;
      inputs = InputState.idle;
      notifyListeners();
    } else if (response.entries.first.key == MessageCreateGoogle.popupClosed) {
      google = RegisterGoogleState.popupClosed;
      inputs = InputState.idle;
      notifyListeners();
    } else {
      google = RegisterGoogleState.error;
      inputs = InputState.idle;
      notifyListeners();
    }
  }
}

InputState _validatingEntries(String email, String senha) {
  if (email.isEmpty || senha.isEmpty) {
    return InputState.empty;
  }
  if (!EmailValidator.validate(email)) {
    return InputState.invalidEmail;
  }
  return InputState.validInput;
}
