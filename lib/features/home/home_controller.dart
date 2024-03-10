import 'package:flutter/material.dart';

import 'package:katyfestascatalog/core/services/firebase_service.dart';

enum Logout { idle, sucess, error }

class HomeController extends ChangeNotifier {
  final FireBaseService client;

  Logout logout = Logout.idle;

  HomeController(this.client);

  Future<void> signOutAll() async {
    MessageSingOut stateLogout = await client.signOut();
    if (stateLogout == MessageSingOut.sucess) {
      logout = Logout.sucess;
      notifyListeners();
    } else {
      logout = Logout.error;
      notifyListeners();
    }
  }
}
