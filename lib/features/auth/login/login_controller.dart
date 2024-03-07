import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/helps/preference.dart';
import 'package:katyfestascatalog/core/services/firebase_service.dart';
import 'package:katyfestascatalog/features/auth/model/auth_request_model.dart';

enum LoginState { idle, loading, success, noUser, wrongPassword, error }

class LoginController extends ChangeNotifier {
  var authRequest = AuthRequestModel('', '');
  var state = LoginState.idle;
  final FireBaseService client;

  LoginController(this.client);

  Future<void> loginAction() async {
    state = LoginState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    var response = await client.signInWithEmailAndPassword(authRequest.email, authRequest.password);
    if (response.entries.first.value != null) {
      AppPreferences.instance.saveString('UserModel', response.toString());
      state = LoginState.success;
      notifyListeners();
    } else if (response.entries.first.key == MessageSign.noUser) {
      state = LoginState.noUser;
      notifyListeners();
    } else if (response.entries.first.key == MessageSign.wrongPassword) {
      state = LoginState.wrongPassword;
      notifyListeners();
    } else {
      state = LoginState.error;
      notifyListeners();
    }
  }
}
