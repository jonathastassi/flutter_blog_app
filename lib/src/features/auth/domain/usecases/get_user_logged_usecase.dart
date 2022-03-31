import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/core/errors/failures.dart';
import 'package:flutter_blog_app/src/core/usecase/usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';

class GetUserLoggedUseCase implements Usecase<UserLoggedEntity, NoParams> {
  GetUserLoggedUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  late final AuthRepository _authRepository;

  @override
  Future<Either<Failure, UserLoggedEntity>> call(NoParams params) =>
      _authRepository.getUserLogged();
}
