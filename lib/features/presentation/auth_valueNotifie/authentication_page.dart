import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/helps/notification_value.dart';
import 'package:katyfestascatalog/core/ui/style/color_style.dart';
import 'package:katyfestascatalog/core/ui/style/text_styles.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:katyfestascatalog/core/dependencies/service_locator.dart';
import 'package:katyfestascatalog/core/ui/custom/circularprogress_custom.dart';
import 'package:katyfestascatalog/features/presentation/auth_valueNotifie/ui/auth_buttom_custom.dart';
import 'package:katyfestascatalog/features/presentation/auth_valueNotifie/ui/google_buttom_custom.dart';
import 'package:katyfestascatalog/features/presentation/auth_valueNotifie/authentication_state.dart';
import 'package:katyfestascatalog/features/viewmodels/auth_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthViewModel _controller;

  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    _controller = getIt<AuthViewModel>();
    setupStateListener(
        _controller.loginFirebaseState,
        onSuccess: (state) => showSuccessSnackbar(state, route: '/home'),
        onError: showErrorSnackbar,
      );

    setupStateListener(
        _controller.loginGoogleState,
        onSuccess: (state) => showSuccessSnackbar(state, route: '/home'),
        onError: showErrorSnackbar,
      );
      
    setupStateListener(
        _controller.registenFirebaseState,
        onSuccess: (state) => showSuccessSnackbar(state,),
        onError: showErrorSnackbar,
      );
  }

  void setupStateListener(
    ValueNotifier<AuthenticationState> stateNotifier, {
    required void Function(AuthenticationSuccess) onSuccess,
    required void Function(AuthenticationError) onError,
  }) {
    stateNotifier.addListener(() {
      final state = stateNotifier.value;

      if (state is AuthenticationError) {
        onError(state);
      }

      if (state is AuthenticationSuccess) {
        onSuccess(state);
      }
    });
  }

  void showErrorSnackbar(AuthenticationError errorState) {
    ScaffoldMessenger.of(context).showSnackBar(
      NotificationCustom.createSnackBar(
        errorState.type,
        errorState.message,
        ColorsCustom.i.red,
        ContentType.failure,
        const Duration(seconds: 2),
      ),
    );
  }

  void showSuccessSnackbar(AuthenticationSuccess successState, {String? route}) {
    ScaffoldMessenger.of(context).showSnackBar(
      NotificationCustom.createSnackBar(
        successState.type,
        successState.message,
        ColorsCustom.i.green,
        ContentType.success,
        const Duration(seconds: 2),
      ),
    ).closed.then((reason) {
      if (route != null && reason != SnackBarClosedReason.action) {
        Navigator.of(context).pushReplacementNamed(route);
      }
    });
  }

  @override
  void dispose() {
    _controller.authRequest;
    _controller.credentialDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width > 650;
    bool isButtomScreen = MediaQuery.of(context).size.width > 420;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorsCustom.i.black,
                  width: 0.3,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              width: isSmallScreen == true ? MediaQuery.of(context).size.width * 0.53 : MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'KATYFESTAS',
                        textAlign: TextAlign.center,
                        style: TextStyles.i.textBold.copyWith(
                          fontSize: 20,
                          color: ColorsCustom.i.black,
                        ),
                      ),
                    ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _controller.authRequest = _controller.authRequest.copyWith(email: value),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _controller.authRequest = _controller.authRequest.copyWith(password: value),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: ValueListenableBuilder<AuthenticationState>(
                          valueListenable: _controller.loginFirebaseState,
                          builder: (context, state, child) {
                            return AuthButtonCustom(
                              buttomWidth: isButtomScreen == true ? 142 : 110,
                              buttomHeight: isButtomScreen == true ? 48 : 24,
                              onPressed: state is! AuthenticationLoading
                                  ? () async => await _controller.loginFireBase()
                                  : null, 
                              loading: state is !AuthenticationIdle
                                  ? const CircularprogressCustom(width: 1.5)
                                  : Text(
                                      textAlign: TextAlign.center,
                                      'ENTRAR',
                                      style: TextStyles.i.textRegular.copyWith(fontSize: isButtomScreen == true ? 14 : 10, color: ColorsCustom.i.white),
                                    ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 30),
                      Flexible(
                        flex: 1,
                        child: ValueListenableBuilder<AuthenticationState>(
                          valueListenable: _controller.registenFirebaseState,
                          builder: (context, state, child) {
                           return AuthButtonCustom(
                              buttomWidth: isButtomScreen == true ? 142 : 110,
                              buttomHeight: isButtomScreen == true ? 48 : 24,
                              onPressed: state is! AuthenticationLoading
                                  ? () async => await _controller.createUserFireBase()
                                  : null, 
                              loading: state is !AuthenticationIdle
                                  ? const CircularprogressCustom(width: 1.5)
                                  : Text(
                                      textAlign: TextAlign.center,
                                      'CADASTRAR',
                                      style: TextStyles.i.textRegular.copyWith(fontSize: isButtomScreen == true ? 14 : 10, color: ColorsCustom.i.white),
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Expanded(child: Divider(color: Colors.grey, height: 1, thickness: 1, indent: 20, endIndent: 20)),
                            Text('Ou continuar com ',
                                textAlign: TextAlign.center,
                                style: TextStyles.i.textLight.copyWith(
                                  fontSize: isButtomScreen ? 14 : 10,
                                  color: ColorsCustom.i.black,
                                )),
                            const Expanded(child: Divider(color: Colors.grey, height: 1, thickness: 1, indent: 20, endIndent: 20)),
                          ],
                        ),
                      ),
                      Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ValueListenableBuilder<AuthenticationState>(
                        valueListenable: _controller.loginFirebaseState,
                        builder: (context, controller, child) {
                          return GoogleButtomCustom(
                            onTap: () => _controller.createUserWithGoogleFireBase(),
                            imagePath: 'assets/images/google.png',
                            heightImage: isButtomScreen == true ? 30 : 20,
                          );
                        },
                      ),
                    ),
                    Text(
                      'Ao prosseguir, você concorda com nossos Termos de Uso e confirma que leu nossa Politicia de Prividade.',
                      textAlign: TextAlign.center,
                      style: TextStyles.i.textLight.copyWith(
                        fontSize: isButtomScreen ? 14 : 10,
                        color: ColorsCustom.i.black,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
