import 'package:equatable/equatable.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.userLoggedEntity,
  });

  const AppState.authenticated(UserLoggedEntity userLoggedEntity)
      : this._(
          status: AppStatus.authenticated,
          userLoggedEntity: userLoggedEntity,
        );

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final UserLoggedEntity? userLoggedEntity;
  final AppStatus status;

  @override
  List<Object?> get props => [
        status,
        userLoggedEntity,
      ];
}
