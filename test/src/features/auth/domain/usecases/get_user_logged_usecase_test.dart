import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/core/usecase/usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('GetUserLoggedUseCase', () {
    late GetUserLoggedUseCase getUserLoggedUseCase;
    late AuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      getUserLoggedUseCase = GetUserLoggedUseCase(
        authRepository: mockAuthRepository,
      );
    });

    test('On call, should execute getUserLogged from auth repository',
        () async {
      when(() => mockAuthRepository.getUserLogged()).thenAnswer(
        // ignore: void_checks
        (_) async => const Right(
          UserLoggedEntity(
            user: UserEntity(
              id: 'id',
              name: 'name',
              email: 'email',
            ),
            authorization: 'authorization',
          ),
        ),
      );

      await getUserLoggedUseCase.call(NoParams());

      verify(() => mockAuthRepository.getUserLogged()).called(1);
    });
  });
}
