import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.loading = false,
    this.error = '',
  });

  final String email;
  final String password;
  final bool loading;
  final String error;

  @override
  List<Object> get props => [
        email,
        password,
        loading,
        error,
      ];

  LoginState copyWith({
    String? email,
    String? password,
    bool? loading,
    String? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}
