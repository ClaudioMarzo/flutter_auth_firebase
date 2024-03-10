import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:katyfestascatalog/features/home/homa_page.dart';
import 'package:katyfestascatalog/features/auth/auth_page.dart';
import 'package:katyfestascatalog/core/ui/theme/theme_config.dart';
import 'package:katyfestascatalog/features/auth/auth_controller.dart';
import 'package:katyfestascatalog/features/home/home_controller.dart';
import 'package:katyfestascatalog/core/services/firebase_service.dart';
// import 'package:katyfestascatalog/features/splash/splash_page.dart';

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
          // '/': (_) => const SplashPage(),
          '/auth': (_) => const AuthPage(),
          '/home': (_) => const HomaPage(),
        },
      ),
    );
  }
}
