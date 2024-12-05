import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:katyfestascatalog/core/ui/theme/theme_config.dart';
import 'package:katyfestascatalog/core/services/firebase_service.dart';
import 'package:katyfestascatalog/features/presentation/home/homa_page.dart';
import 'package:katyfestascatalog/features/presentation/home/home_controller.dart';
import 'package:katyfestascatalog/features/presentation/auth_changeNotifie/auth_controller.dart';
import 'package:katyfestascatalog/features/presentation/auth_valueNotifie/authentication_page.dart';

class CatalagoWidget extends StatelessWidget {
  const CatalagoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FireBaseService()),
        ChangeNotifierProvider(create: (context) => AuthController(context.read())),
        ChangeNotifierProvider(create: (context) => HomeController(context.read())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Katy Festa Catalago',
        theme: ThemeConfig.theme,
        initialRoute: '/auth',
        routes: {
          // '/auth': (_) => const AuthPage(),
          '/auth': (_) => const LoginPage(),
          '/home': (_) => const HomaPage(),
        },
      ),
    );
  }
}
