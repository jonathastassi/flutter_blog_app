import 'dart:ffi';
import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/save_user_logged_on_local_storage_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  const userLoggedEntity = UserLoggedEntity(
    user: UserEntity(
      id: 'someId',
      name: 'someName',
      email: 'someEmail@email.com',
    ),
    authorization: 'someAuthorization',
  );

  group('SaveUserLoggedOnLocalStorageUseCase', () {
    late SaveUserLoggedOnLocalStorageUseCase
        saveUserLoggedOnLocalStorageUseCase;
    late AuthRepository mockAuthRepository;

    setUpAll(() {
      registerFallbackValue(userLoggedEntity);
    });

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      saveUserLoggedOnLocalStorageUseCase = SaveUserLoggedOnLocalStorageUseCase(
        authRepository: mockAuthRepository,
      );
    });

    test(
        'When SaveUserLoggedOnLocalStorageUseCase is called, should call saveUserLogged from AuthRepository',
        () async {
      when(() => mockAuthRepository.saveUserLogged(any())).thenAnswer(
        // ignore: void_checks
        (_) async => const Right(Void),
      );

      await saveUserLoggedOnLocalStorageUseCase.call(userLoggedEntity);

      verify(() => mockAuthRepository.saveUserLogged(userLoggedEntity))
          .called(1);
    });
  });
}
