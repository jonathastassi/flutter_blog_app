import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.loading = false,
    this.error = '',
  });

  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool loading;
  final String error;

  @override
  List<Object> get props => [
        name,
        email,
        password,
        confirmPassword,
        loading,
        error,
      ];

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? loading,
    String? error,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}
