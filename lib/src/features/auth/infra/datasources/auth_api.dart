import 'package:flutter_blog_app/src/features/auth/infra/models/user_logged_model.dart';

abstract class AuthApi {
  Future<UserLoggedModel?> login({
    required String email,
    required String password,
  });

  Future<UserLoggedModel> register({
    required String name,
    required String email,
    required String password,
  });
}
