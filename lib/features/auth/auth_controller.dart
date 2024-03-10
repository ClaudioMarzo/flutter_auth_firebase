import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/services/firebase_service.dart';
import 'package:katyfestascatalog/features/auth/model/auth_request_model.dart';

enum LoginState { idle, loading, success, infoInvalid, error }

enum RegisterState { idle, loading, success, accountExit, error }

enum RegisterGoogleState { idle, loading, success, error }

enum InputState { idle, validInput, invalidEmail, empty }

class AuthController extends ChangeNotifier {
  final FireBaseService client;
  LoginState login = LoginState.idle;
  InputState inputs = InputState.idle;
  RegisterState register = RegisterState.idle;
  RegisterGoogleState google = RegisterGoogleState.idle;
  AuthRequestModel authRequest = AuthRequestModel('', '');

  AuthController(this.client);

  Future<void> loginAccountAction() async {
    login = LoginState.loading;
    register = RegisterState.idle;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    inputs = validatingEntries(authRequest.email, authRequest.password);
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
    register = RegisterState.loading;
    login = LoginState.idle;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    inputs = validatingEntries(authRequest.email, authRequest.password);
    notifyListeners();
    if (inputs == InputState.validInput) {
      var response = await client.createUserWithEmailAndPassword(authRequest.email, authRequest.password);
      if (response.entries.first.value != null) {
        register = RegisterState.success;
        notifyListeners();
      } else if (response.entries.first.key == MessageCreate.emailExist) {
        register = RegisterState.accountExit;
        notifyListeners();
      } else {
        register = RegisterState.error;
        notifyListeners();
      }
    } else {
      register = RegisterState.idle;
      inputs = InputState.idle;
      notifyListeners();
    }
  }

  Future<void> accountGoogleAction() async {
    login = LoginState.idle;
    register = RegisterState.idle;
    google = RegisterGoogleState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    var response = await client.createUserWithGoogleAccount();
    if (response.entries.first.key == MessageCreateGoogle.sucess) {
      google = RegisterGoogleState.success;
      notifyListeners();
    } else {
      google = RegisterGoogleState.error;
      notifyListeners();
    }
  }
}

InputState validatingEntries(String email, String senha) {
  if (email.isEmpty || senha.isEmpty) {
    return InputState.empty;
  }
  if (!EmailValidator.validate(email)) {
    return InputState.invalidEmail;
  }
  return InputState.validInput;
}
