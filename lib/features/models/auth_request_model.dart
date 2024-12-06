class UserModel {
  final String email;
  final String password;

  UserModel(
    this.email,
    this.password,
  );

  UserModel copyWith({String? email, String? password}) {
    return UserModel(
      email ?? this.email,
      password ?? this.password,
    );
  }
}
