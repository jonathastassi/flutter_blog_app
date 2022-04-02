import 'package:equatable/equatable.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';

abstract class AppState extends Equatable {}

class AuthenticatedState extends AppState {
  AuthenticatedState({
    required this.userLoggedEntity,
  });

  final UserLoggedEntity userLoggedEntity;

  @override
  List<Object?> get props => [
        userLoggedEntity,
      ];
}

class UnauthenticatedState extends AppState {
  @override
  List<Object?> get props => [];
}
