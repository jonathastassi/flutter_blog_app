import 'package:equatable/equatable.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';

class UserLoggedEntity extends Equatable {
  const UserLoggedEntity({
    required this.user,
    required this.authorization,
  });

  final UserEntity user;
  final String authorization;

  @override
  List<Object?> get props => [
        user,
        authorization,
      ];
}
