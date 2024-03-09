import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:katyfestascatalog/core/ui/style/color_style.dart';
import 'package:katyfestascatalog/core/ui/custom/app_bar_custom.dart';
import 'package:katyfestascatalog/core/ui/custom/square_buttom_custom.dart';
import 'package:katyfestascatalog/features/auth/accounts/accounts.controller.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccounthsPageState();
}

class _AccounthsPageState extends State<AccountsPage> {
  late AccountsController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<AccountsController>();
    controller.addListener(
      () {
        if (controller.state == AccountState.accountExit) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ColorsCustom.i.yellow,
              content: const Text('Conta de usuário já existe'),
            ),
          );
        } else if (controller.state == AccountState.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ColorsCustom.i.yellow,
              content: const Text('Erro ao logar com a conta Google'),
            ),
          );
        } else if (controller.state == AccountState.sucess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ColorsCustom.i.gree,
              content: const Text('Login feito com sucesso'),
            ),
          );
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
    );
  }

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
              Consumer<AccountsController>(
                builder: (context, controller, child) {
                  return SquareButtomCustom(
                    onTap: () => controller.accountAction(),
                    imagePath: 'assets/images/google.png',
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
