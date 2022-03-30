import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.id = '',
    this.name = '',
    this.email = '',
    this.password = '',
  });

  final String id;
  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => [id];
}
