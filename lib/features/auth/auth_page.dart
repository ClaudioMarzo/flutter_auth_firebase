import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/ui/custom/buttom_custom.dart';
import 'package:provider/provider.dart';
import 'package:katyfestascatalog/features/auth/auth_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();
    controller.addListener(
      () {
        if (controller.state == AuthState.noUser) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nenhum usuário encontrado para esse e-mail.'),
            ),
          );
        } else if (controller.state == AuthState.wrongPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Senha errada fornecida para esse usuário.'),
            ),
          );
        } else if (controller.state == AuthState.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro ao autenticar'),
            ),
          );
        } else if (controller.state == AuthState.success) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final controller = context.watch<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<AuthController>(builder: (context, controller, child) {
              return TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                onChanged: (value) {
                  controller.authRequest = controller.authRequest.copyWith(email: value);
                },
              );
            }),
            const SizedBox(width: 20),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Passord',
              ),
              onChanged: (value) {
                controller.authRequest = controller.authRequest.copyWith(password: value);
              },
            ),
            const SizedBox(width: 20),
            Consumer<AuthController>(
              builder: (context, controller, child) {
                return ButtonCustom(
                  label: 'LOGIN',
                  onPressed: controller.state == AuthState.loading ? null : () => controller.loginAction(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
