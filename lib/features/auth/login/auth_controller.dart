import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/helps/preference.dart';
import 'package:katyfestascatalog/core/services/firebase_service.dart';
import 'package:katyfestascatalog/features/auth/login/model/auth_request_model.dart';

enum AuthState { idle, success, loading, noUser, wrongPassword, error }

class AuthController extends ChangeNotifier {
  var authRequest = AuthRequestModel('', '');
  var state = AuthState.idle;
  final FireBaseService client;

  AuthController(this.client);

  Future<void> loginAction() async {
    state = AuthState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    var response = await client.signInWithEmailAndPassword(authRequest.email, authRequest.password);
    if (response.entries.first.value != null) {
      AppPreferences.instance.saveString('UserModel', response.toString());
      state = AuthState.success;
      notifyListeners();
    } else if (response.entries.first.key == MessageSign.noUser) {
      state = AuthState.noUser;
      notifyListeners();
    } else if (response.entries.first.key == MessageSign.wrongPassword) {
      state = AuthState.wrongPassword;
      notifyListeners();
    } else {
      state = AuthState.error;
      notifyListeners();
    }
  }
}
