import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.id = '',
    this.name = '',
    this.email = '',
    this.password = '',
  });

  UserEntity withoutPassword() => UserEntity(
        email: email,
        id: id,
        name: name,
      );

  final String id;
  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => [id];
}
