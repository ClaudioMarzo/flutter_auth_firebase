import 'package:flutter/material.dart';
import 'package:katyfestascatalog/features/home/homa_page.dart';

class Katyfesta extends StatelessWidget {
  const Katyfesta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katy Festa Catalago',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomaPage(),
      },
    );
  }
}
