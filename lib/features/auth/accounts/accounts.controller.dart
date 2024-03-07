import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/services/firebase_service.dart';
import 'package:katyfestascatalog/features/auth/model/auth_request_model.dart';

enum AccountState { idle, loading, sucess, accountExit, error }

class AccountsController extends ChangeNotifier {
  var authRequest = AuthRequestModel('', '');
  var state = AccountState.idle;
  final FireBaseService client;

  AccountsController(this.client);

  Future<void> accountAction() async {
    state = AccountState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    var response = await client.createUserWithGoogleAccount();
    if (response.entries.first.key == MessageCreateGoogle.sucess) {
      state = AccountState.sucess;
      notifyListeners();
    }
    state = AccountState.error;
    notifyListeners();
  }
}
