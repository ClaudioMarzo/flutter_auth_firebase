import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/ui/custom/app_bar_custom.dart';
import 'package:katyfestascatalog/features/presentation/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({super.key});

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<HomeController>();
    controller.addListener(
      () {
        if (controller.logout == Logout.sucess) {
          Navigator.of(context).pushReplacementNamed('/auth');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home Page',
        onPressedSign: null,
        onPressedOut: () => controller.signOutAll(),
      ),
      body: Container(),
    );
  }
}
