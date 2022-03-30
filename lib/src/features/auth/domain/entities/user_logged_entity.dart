import 'package:equatable/equatable.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';

class UserLoggedEntity extends Equatable {
  const UserLoggedEntity({
    required this.user,
    required this.token,
  });

  final UserEntity user;
  final String token;

  @override
  List<Object?> get props => throw UnimplementedError();
}
