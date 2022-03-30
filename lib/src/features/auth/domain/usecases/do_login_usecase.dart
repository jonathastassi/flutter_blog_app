import 'package:flutter_blog_app/src/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/core/usecase/usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';

class DoLoginUseCase implements Usecase<UserEntity, LoginEntity> {
  DoLoginUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  late final AuthRepository _authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(LoginEntity params) =>
      _authRepository.login(params);
}
