import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:katyfestascatalog/core/helps/preference.dart';
import 'package:katyfestascatalog/features/catalago_widget.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.instance.initPreferences();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CatalagoWidget());
}
