import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/ui/custom/app_bar_custom.dart';
import 'package:katyfestascatalog/core/ui/custom/square_buttom_custom.dart';
import 'package:katyfestascatalog/core/providers/auth_providers.dart';

class AccounthsPage extends StatefulWidget {
  const AccounthsPage({super.key});

  @override
  State<AccounthsPage> createState() => _AccounthsPageState();
}

class _AccounthsPageState extends State<AccounthsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        titletext: 'Login',
        isExit: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SquareButtomCustom(
                onTap: () => AuthProviders().signInWithGoogle(),
                imagePath: 'assets/images/google.png',
              )
            ],
          ),
        ),
      ),
    );
  }
}
