import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/core/errors/failures.dart';
import 'package:flutter_blog_app/src/core/usecase/usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';

class DoLogoutUseCase implements Usecase<void, NoParams> {
  DoLogoutUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  late final AuthRepository _authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) =>
      _authRepository.logout();
}
