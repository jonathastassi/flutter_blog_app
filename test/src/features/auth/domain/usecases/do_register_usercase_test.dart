import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/register_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_login_usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_register_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  const registerEntity = RegisterEntity(
    email: 'someEmail@email.com',
    password: 'somePassword',
    name: 'someName',
  );

  const userEntity = UserEntity(
    id: 'someId',
    name: 'someName',
    email: 'someEmail@email.com',
  );

  group('DoRegisterUseCase', () {
    late DoRegisterUseCase doRegisterUseCase;
    late AuthRepository mockAuthRepository;

    setUpAll(() {
      registerFallbackValue(registerEntity);
    });

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      doRegisterUseCase = DoRegisterUseCase(
        authRepository: mockAuthRepository,
      );
    });

    test(
        'When DoRegisterUseCase is called, should call register from AuthRepository',
        () async {
      when(() => mockAuthRepository.register(any())).thenAnswer(
        (_) async => const Right(
          userEntity,
        ),
      );

      await doRegisterUseCase.call(registerEntity);

      verify(() => mockAuthRepository.register(registerEntity)).called(1);
    });

    test('When DoRegisterUseCase is called, should return a UserEntity',
        () async {
      when(() => mockAuthRepository.register(any())).thenAnswer(
        (_) async => const Right(
          userEntity,
        ),
      );

      final response = await doRegisterUseCase.call(registerEntity);

      response.fold((_) {}, (user) {
        expect(user.id, 'someId');
        expect(user.name, 'someName');
        expect(user.email, 'someEmail@email.com');
      });
    });
  });
}
