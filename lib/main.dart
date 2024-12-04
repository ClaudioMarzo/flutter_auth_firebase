import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:katyfestascatalog/core/helps/preference.dart';
import 'package:katyfestascatalog/features/catalago_widget.dart';
import 'package:katyfestascatalog/core/dependencies/service_locator.dart';

void main() async {
  await AppPreferences.instance.initPreferences();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  runApp(const CatalagoWidget());
}
