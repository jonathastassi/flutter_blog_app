import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  const loginEntity = LoginEntity(
    email: 'someEmail@email.com',
    password: 'somePassword',
  );

  const userEntity = UserLoggedEntity(
    user: UserEntity(
      id: 'someId',
      name: 'someName',
      email: 'someEmail@email.com',
    ),
    authorization: 'someAuthorization',
  );

  group('DoLoginUseCase', () {
    late DoLoginUseCase doLoginUseCase;
    late AuthRepository mockAuthRepository;

    setUpAll(() {
      registerFallbackValue(loginEntity);
    });

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      doLoginUseCase = DoLoginUseCase(
        authRepository: mockAuthRepository,
      );
    });

    test('When DoLoginUseCase is called, should call login from AuthRepository',
        () async {
      when(() => mockAuthRepository.login(any())).thenAnswer(
        (_) async => const Right(
          userEntity,
        ),
      );

      await doLoginUseCase.call(loginEntity);

      verify(() => mockAuthRepository.login(loginEntity)).called(1);
    });

    test('When DoLoginUseCase is called, should return a UserEntity', () async {
      when(() => mockAuthRepository.login(any())).thenAnswer(
        (_) async => const Right(
          userEntity,
        ),
      );

      final response = await doLoginUseCase.call(loginEntity);

      response.fold((_) {}, (data) {
        expect(data.user.id, 'someId');
        expect(data.user.name, 'someName');
        expect(data.user.email, 'someEmail@email.com');
        expect(data.authorization, 'someAuthorization');
      });
    });
  });
}
