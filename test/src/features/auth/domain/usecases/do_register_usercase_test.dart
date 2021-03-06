import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/register_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';
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

  const userEntity = UserLoggedEntity(
    user: UserEntity(
      id: 'someId',
      name: 'someName',
      email: 'someEmail@email.com',
    ),
    authorization: 'someAuthorization',
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

      response.fold((_) {}, (data) {
        expect(data.user.id, 'someId');
        expect(data.user.name, 'someName');
        expect(data.user.email, 'someEmail@email.com');
        expect(data.authorization, 'someAuthorization');
      });
    });
  });
}
