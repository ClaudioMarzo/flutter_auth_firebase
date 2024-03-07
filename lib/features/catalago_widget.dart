import 'package:flutter/material.dart';
import 'package:katyfestascatalog/features/auth/accounts/accounts.controller.dart';
import 'package:provider/provider.dart';
import 'package:katyfestascatalog/features/home/homa_page.dart';
import 'package:katyfestascatalog/core/ui/theme/theme_config.dart';
import 'package:katyfestascatalog/features/auth/login/login_page.dart';
import 'package:katyfestascatalog/core/services/firebase_service.dart';
import 'package:katyfestascatalog/features/auth/login/login_controller.dart';
import 'package:katyfestascatalog/features/auth/accounts/accounts_page.dart';
// import 'package:katyfestascatalog/features/splash/splash_page.dart';

class CatalagoWidget extends StatelessWidget {
  const CatalagoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FireBaseService()),
        ChangeNotifierProvider(create: (context) => LoginController(context.read())),
        ChangeNotifierProvider(create: (context) => AccountsController(context.read())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Katy Festa Catalago',
        theme: ThemeConfig.theme,
        initialRoute: '/accounths',
        routes: {
          // '/': (_) => const SplashPage(),
          '/auth': (_) => const AuthPage(),
          '/accounths': (_) => const AccountsPage(),
          '/home': (_) => const HomaPage(),
        },
      ),
    );
  }
}
