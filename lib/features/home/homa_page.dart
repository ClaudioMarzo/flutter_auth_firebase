import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/ui/custom/app_bar_custom.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({super.key});

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        titletext: 'Home Page',
        isExit: true,
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: Container(),
    );
  }
}
