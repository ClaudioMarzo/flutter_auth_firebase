abstract class AuthenticationState {}

class AuthenticationIdle implements AuthenticationState {
  const AuthenticationIdle();
}

class AuthenticationLoading implements AuthenticationState {
  const AuthenticationLoading();
}

class AuthenticationSuccess implements AuthenticationState {
  final String type;
  final String message;
  const AuthenticationSuccess(this.type, this.message);
}

class AuthenticationError implements AuthenticationState {
  final String type;
  final String message;
  const AuthenticationError(this.type, this.message);
}
