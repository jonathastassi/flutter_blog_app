import 'package:faker/faker.dart';
import 'package:flutter_blog_app/src/features/auth/infra/datasources/auth_api.dart';
import 'package:flutter_blog_app/src/features/auth/infra/models/user_logged_model.dart';
import 'package:flutter_blog_app/src/features/auth/infra/models/user_model.dart';

class AuthApiImpl implements AuthApi {
  AuthApiImpl({Faker? faker}) : _faker = faker ?? Faker();

  final Faker _faker;

  @override
  Future<UserLoggedModel?> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'emailvalido@gmail.com' && password == '12345678') {
      return UserLoggedModel(
        user: UserModel(
          id: _faker.guid.guid(),
          email: email,
          name: password,
        ),
        authorization: _faker.jwt.valid(),
      );
    }
    return null;
  }

  @override
  Future<UserLoggedModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    return UserLoggedModel(
      user: UserModel(
        id: _faker.guid.guid(),
        email: email,
        name: name,
      ),
      authorization: _faker.jwt.valid(),
    );
  }
}
