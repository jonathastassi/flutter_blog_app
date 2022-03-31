import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';

abstract class AuthApi {
  Future<UserLoggedEntity?> login({
    required String email,
    required String password,
  });

  Future<UserLoggedEntity> register({
    required String name,
    required String email,
    required String password,
  });
}
