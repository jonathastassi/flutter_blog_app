import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/core/errors/failures.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/register_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserLoggedEntity>> login(
    LoginEntity loginEntity,
  );

  Future<Either<Failure, UserLoggedEntity>> register(
    RegisterEntity registerEntity,
  );

  Future<Either<Failure, void>> saveUserLogged(
    UserLoggedEntity userLoggedEntity,
  );

  Future<Either<Failure, void>> logout();
}
