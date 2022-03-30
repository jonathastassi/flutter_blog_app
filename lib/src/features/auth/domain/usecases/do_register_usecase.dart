import 'package:flutter_blog_app/src/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/core/usecase/usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/register_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';

class DoRegisterUseCase implements Usecase<UserEntity, RegisterEntity> {
  DoRegisterUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  late final AuthRepository _authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(RegisterEntity params) =>
      _authRepository.register(params);
}
