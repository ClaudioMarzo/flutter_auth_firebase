import 'package:flutter/foundation.dart';
import 'package:katyfestascatalog/features/data/models/auth_request_model.dart';
import 'package:katyfestascatalog/features/domain/interface/interface_auth_google.dart';
import 'package:katyfestascatalog/features/domain/interface/interface_auth_firebase.dart';
import 'package:katyfestascatalog/features/presentation/auth_valueNotifie/authentication_state.dart';

class AuthenticationStateController {
  final InterfaceAuthFireBase _firebaseRepository;
  final InterfaceAuthGoogle _googleRepository;
  AuthRequestModel authRequest = AuthRequestModel('', '');

  AuthenticationStateController(this._firebaseRepository, this._googleRepository);

  ValueNotifier<AuthenticationState> loginFirebaseState = ValueNotifier<AuthenticationState>(const AuthenticationIdle());
  ValueNotifier<AuthenticationState> registenFirebaseState = ValueNotifier<AuthenticationState>(const AuthenticationIdle());
  ValueNotifier<AuthenticationState> loginGoogleState = ValueNotifier<AuthenticationState>(const AuthenticationIdle());

  //ESTADO PARA BOTÃO LOGIN
  void setLoginIdle() => loginFirebaseState.value = const AuthenticationIdle();
  void setLoginLoading() => loginFirebaseState.value = const AuthenticationLoading();
  void setLoginSuccess(String type, String message) => loginFirebaseState.value = AuthenticationSuccess(type, message);
  void setLoginError(String type, String message) => loginFirebaseState.value = AuthenticationError(type, message);

  //ESTADO PARA BOTÃO REGISTRAR
  void setRegisterIdle() => registenFirebaseState.value = const AuthenticationIdle();
  void setRegisterLoading() => registenFirebaseState.value = const AuthenticationLoading();
  void setRegisterSuccess(String type, String message) => registenFirebaseState.value = AuthenticationSuccess(type, message);
  void setRegisterError(String type, String message) => registenFirebaseState.value = AuthenticationError(type, message);
  
  //ESTADO PARA BOTÃO LOGIN COM GOOGLE
  void setGoogleLoginSuccess(String type, String message) => loginGoogleState.value = AuthenticationSuccess(type, message);
  void setGoogleLoginError(String type, String message) => loginGoogleState.value = AuthenticationError(type, message);
  
  //IMPLEMENTAÇÃOES PARA REQUEST COM FIRE BASE

  //----------------------------------------------------------------------------------------------------
  //LOGAR USUÁRIO COM E-MAIL E SENHA
  //----------------------------------------------------------------------------------------------------
  Future<void> loginFireBase() async {
    if (authRequest.email.isEmpty || authRequest.password.isEmpty) {
      setLoginError('Imput', 'Email ou Senha estão vazios.');
      setLoginIdle();
      return;
    }
    setLoginLoading();
    try {
      final user = await _firebaseRepository.signInWithEmailAndPassword(authRequest.email, authRequest.password);
      user != null ? setLoginSuccess('Sucesso', 'Seja bem vindo') : setLoginError('Registro', 'Falha no login. Usuário não cadastrado.');
    } catch (e) {
      switch (e) {
        case 'invalid-email':
          setLoginError('Error', 'E-mail inválido');
        case 'invalid-credential':
          setLoginError('Error', 'Senha inválida');
        default:
          setLoginError('Error', 'Erro ao cadastrar usuário');
      }
    }
    setLoginIdle(); 
  }
  //----------------------------------------------------------------------------------------------------
  //CRIAR USUÁRIO COM E-MAIL E SENHA
  //----------------------------------------------------------------------------------------------------
  Future<void> createUserFireBase() async {
    if (authRequest.email.isEmpty || authRequest.password.isEmpty) {
      setRegisterError('Imput', 'Email ou Senha estão vazios.');
      setRegisterIdle();
      return;
    }
    setRegisterLoading();
    try {
      final user = await _firebaseRepository.createUserWithEmailAndPassword(authRequest.email, authRequest.password);
      user != null ? setRegisterSuccess('Cadastro', 'Cadastro feito com sucesso') : setRegisterError('Error', 'Falha ao cadastrar usuário');
    } catch (e) {
      switch (e) {
        case 'weak-password':
          setRegisterError('Error', 'Senha fraca : adicione caracteres, letras e números');
        case 'invalid-email':
          setRegisterError('Error', 'E-mail inválido');
        case 'email-already-in-use':
          setRegisterError('Error', 'Usuário já está cadastrado');
        default:
          setRegisterError('Error', 'Erro ao cadastrar usuário');
      }
    }
    setRegisterIdle();
  }

  //----------------------------------------------------------------------------------------------------
  //LOGAR USUÁRIO COM CONTA GOOGLE
  //----------------------------------------------------------------------------------------------------
  Future<void> createUserWithGoogleFireBase() async{
    try{
      final user = await _googleRepository.createUserWithGoogleAccount();
      user != null ? setGoogleLoginSuccess('Cadastro', 'Cadastro feito com sucesso') : setGoogleLoginError('Error', 'Falha ao cadastrar usuário');
    }catch(e){
      switch (e) {
        case 'cancelled-popup-request':
          setGoogleLoginError('Error', 'Pop Up fechado.');
        case 'user-not-found':
          setGoogleLoginError('Error', 'Nenhum usuário encontrado para esse e-mail.');
        case 'wrong-password':
          setGoogleLoginError('Error', 'Senha errada fornecida para esse usuário.');
        default:
          setGoogleLoginError('Error', 'Erro de autenticação.');
      }
    }
  }
}