import 'package:flutter/foundation.dart';
import 'package:katyfestascatalog/features/models/auth_request_model.dart';
import 'package:katyfestascatalog/features/service/interfaces/i_auth_firebase.dart';
import 'package:katyfestascatalog/features/presentation/auth_valueNotifie/authentication_state.dart';

class AuthViewModel {
  final IAuthFireBase _firebaseService;
  UserModel authRequest = UserModel('', '');

  AuthViewModel(this._firebaseService);

  ValueNotifier<AuthenticationState> loginFirebaseState = ValueNotifier<AuthenticationState>(const AuthenticationIdle());
  ValueNotifier<AuthenticationState> registenFirebaseState = ValueNotifier<AuthenticationState>(const AuthenticationIdle());
  ValueNotifier<AuthenticationState> loginGoogleState = ValueNotifier<AuthenticationState>(const AuthenticationIdle());

  //ESTADO PARA BOTÃO LOGIN
  void _setLoginIdle() => loginFirebaseState.value = const AuthenticationIdle();
  void _setLoginLoading() => loginFirebaseState.value = const AuthenticationLoading();
  void _setLoginSuccess(String type, String message) => loginFirebaseState.value = AuthenticationSuccess(type, message);
  void _setLoginError(String type, String message) => loginFirebaseState.value = AuthenticationError(type, message);

  //ESTADO PARA BOTÃO REGISTRAR
  void _setRegisterIdle() => registenFirebaseState.value = const AuthenticationIdle();
  void _setRegisterLoading() => registenFirebaseState.value = const AuthenticationLoading();
  void _setRegisterSuccess(String type, String message) => registenFirebaseState.value = AuthenticationSuccess(type, message);
  void _setRegisterError(String type, String message) => registenFirebaseState.value = AuthenticationError(type, message);
  
  //ESTADO PARA BOTÃO LOGIN COM GOOGLE
  void _setGoogleLoginSuccess(String type, String message) => loginGoogleState.value = AuthenticationSuccess(type, message);
  void _setGoogleLoginError(String type, String message) => loginGoogleState.value = AuthenticationError(type, message);
  
  //IMPLEMENTAÇÃOES PARA REQUEST COM FIRE BASE

  //----------------------------------------------------------------------------------------------------
  //LOGAR USUÁRIO COM E-MAIL E SENHA
  //----------------------------------------------------------------------------------------------------
  Future<void> loginFireBase() async {
    if (authRequest.email.isEmpty || authRequest.password.isEmpty) {
      _setLoginError('Imput', 'Email ou Senha estão vazios.');
      _setLoginIdle();
      return;
    }
    _setLoginLoading();
    try {
      final user = await _firebaseService.signInWithEmailAndPassword(authRequest.email, authRequest.password);
      user != null ? _setLoginSuccess('Sucesso', 'Seja bem vindo') : _setLoginError('Registro', 'Falha no login. Usuário não cadastrado.');
    } catch (e) {
      switch (e) {
        case 'invalid-email':
          _setLoginError('Error', 'E-mail inválido');
        case 'invalid-credential':
          _setLoginError('Error', 'Senha inválida');
        default:
          _setLoginError('Error', 'Erro ao cadastrar usuário');
      }
    }
    _setLoginIdle(); 
  }
  //----------------------------------------------------------------------------------------------------
  //CRIAR USUÁRIO COM E-MAIL E SENHA
  //----------------------------------------------------------------------------------------------------
  Future<void> createUserFireBase() async {
    if (authRequest.email.isEmpty || authRequest.password.isEmpty) {
      _setRegisterError('Imput', 'Email ou Senha estão vazios.');
      _setRegisterIdle();
      return;
    }
    _setRegisterLoading();
    try {
      final user = await _firebaseService.createUserWithEmailAndPassword(authRequest.email, authRequest.password);
      user != null ? _setRegisterSuccess('Cadastro', 'Cadastro feito com sucesso') : _setRegisterError('Error', 'Falha ao cadastrar usuário');
    } catch (e) {
      switch (e) {
        case 'weak-password':
          _setRegisterError('Error', 'Senha fraca : adicione caracteres, letras e números');
        case 'invalid-email':
          _setRegisterError('Error', 'E-mail inválido');
        case 'email-already-in-use':
          _setRegisterError('Error', 'Usuário já está cadastrado');
        default:
          _setRegisterError('Error', 'Erro ao cadastrar usuário');
      }
    }
    _setRegisterIdle();
  }

  //----------------------------------------------------------------------------------------------------
  //LOGAR USUÁRIO COM CONTA GOOGLE
  //----------------------------------------------------------------------------------------------------
  Future<void> createUserWithGoogleFireBase() async {
    try{
      final user = await _firebaseService.createUserWithGoogleAccount();
      user != null ? _setGoogleLoginSuccess('Cadastro', 'Cadastro feito com sucesso') : _setGoogleLoginError('Error', 'Falha ao cadastrar usuário');
    }catch(e){
      switch (e) {
        case 'cancelled-popup-request':
          _setGoogleLoginError('Error', 'Pop Up fechado.');
        case 'user-not-found':
          _setGoogleLoginError('Error', 'Nenhum usuário encontrado para esse e-mail.');
        case 'wrong-password':
          _setGoogleLoginError('Error', 'Senha errada fornecida para esse usuário.');
        default:
          _setGoogleLoginError('Error', 'Erro de autenticação.');
      }
    }
  }
  //----------------------------------------------------------------------------------------------------
  //LIMPAR CREDENCIAIS
  //----------------------------------------------------------------------------------------------------
  Future<void> credentialDispose() async {
    try{
      await _firebaseService.signOutFireBase();
    }catch (e){
      rethrow;
    }
  }
}