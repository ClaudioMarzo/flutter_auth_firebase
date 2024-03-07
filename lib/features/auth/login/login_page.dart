import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:katyfestascatalog/core/ui/style/color_style.dart';
import 'package:katyfestascatalog/core/ui/custom/buttom_custom.dart';
import 'package:katyfestascatalog/core/ui/custom/app_bar_custom.dart';
import 'package:katyfestascatalog/features/auth/login/login_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<LoginController>();
    controller.addListener(
      () {
        if (controller.state == LoginState.noUser) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ColorsCustom.i.yellow,
              content: const Text('Nenhum usuário encontrado para esse e-mail.'),
            ),
          );
        } else if (controller.state == LoginState.wrongPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ColorsCustom.i.yellow,
              content: const Text('Senha errada fornecida para esse usuário.'),
            ),
          );
        } else if (controller.state == LoginState.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ColorsCustom.i.red,
              content: const Text('Erro ao autenticar'),
            ),
          );
        } else if (controller.state == LoginState.success) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final controller = context.watch<AuthController>();
    return Scaffold(
      appBar: AppBarCustom(
        titletext: 'Login',
        isExit: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 500,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                onChanged: (value) {
                  controller.authRequest = controller.authRequest.copyWith(email: value);
                },
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Passord',
                ),
                onChanged: (value) {
                  controller.authRequest = controller.authRequest.copyWith(password: value);
                },
              ),
              const SizedBox(height: 30),
              Consumer<LoginController>(
                builder: (context, controller, child) {
                  return ButtonCustom(
                    label: 'LOGIN',
                    onPressed: controller.state == LoginState.loading ? null : () => controller.loginAction(),
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
