abstract class AuthenticationState {}

class AuthenticationIdle implements AuthenticationState {
  const AuthenticationIdle();
}

class AuthenticationLoading implements AuthenticationState {
  const AuthenticationLoading();
}

class AuthenticationSuccess implements AuthenticationState {
  const AuthenticationSuccess();
}

class AuthenticationError implements AuthenticationState {
  final String message;
  const AuthenticationError(this.message);
}
