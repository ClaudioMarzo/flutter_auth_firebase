import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/dependencies/service_locator.dart';
import 'package:katyfestascatalog/features/presentation/authentication/authentication_controller.dart';
import 'package:katyfestascatalog/features/presentation/authentication/authentication_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthenticationStateController _controller;

  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    _controller = getIt<AuthenticationStateController>();
  }

  @override
  void dispose() {
    _controller.state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => setState(() => email = value),
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => setState(() => password = value),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ValueListenableBuilder<AuthenticationState>(
              valueListenable: _controller.state,
              builder: (context, state, child) {
                if (state is AuthenticationLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is AuthenticationIdle){
                  return ElevatedButton(
                    onPressed: email.isNotEmpty && password.isNotEmpty
                        ? () async {          
                            await _controller.loginFireBase(email, password);
                          }
                        : null,
                    child: const Text('Login'),
                  );
                }
                if (state is AuthenticationError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return Container();
              }
            ),
          ],
        ),
      ),
    );
  }
}
