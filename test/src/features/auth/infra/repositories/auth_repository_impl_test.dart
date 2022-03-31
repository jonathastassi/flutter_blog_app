import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blog_app/src/core/constants/contants.dart';
import 'package:flutter_blog_app/src/core/errors/failures.dart';
import 'package:flutter_blog_app/src/core/secure_storage/secure_storage.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/register_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_blog_app/src/features/auth/infra/datasources/auth_api.dart';
import 'package:flutter_blog_app/src/features/auth/infra/models/user_logged_model.dart';
import 'package:flutter_blog_app/src/features/auth/infra/models/user_model.dart';
import 'package:flutter_blog_app/src/features/auth/infra/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements SecureStorage {}

class MockAuthApi extends Mock implements AuthApi {}

void main() {
  const userLoggedJson = '''
  {
    "user": {
      "id": "someId",
      "name": "someName",
      "email": "someEmail"
    },
    "authorization": "someAuthorization"
  }
  ''';

  const userLoggedEntity = UserLoggedEntity(
    user: UserEntity(
      id: 'someId',
      name: 'someName',
      email: 'someEmail',
    ),
    authorization: 'someAuthorization',
  );

  const loginEntity = LoginEntity(
    email: 'someEmail',
    password: 'somePassword',
  );

  const registerEntity = RegisterEntity(
    name: 'someName',
    email: 'someEmail',
    password: 'somePassword',
  );

  group('AuthRepositoryImpl', () {
    late AuthRepository authRepository;
    late SecureStorage mockSecureStorage;
    late AuthApi mockAuthApi;

    setUp(() {
      mockSecureStorage = MockSecureStorage();
      mockAuthApi = MockAuthApi();
      authRepository = AuthRepositoryImpl(
        secureStorage: mockSecureStorage,
        authApi: mockAuthApi,
      );
    });

    group('getUserLogged', () {
      test(
          'When user data is stored in local Storage, should return UserLoggedModel',
          () async {
        when(
          () => mockSecureStorage.read(Constants.keyUserLoggedStored),
        ).thenAnswer(
          (_) async => userLoggedJson,
        );

        final response = await authRepository.getUserLogged();

        expect(
          response,
          const Right<Failure, UserLoggedEntity>(
            UserLoggedModel(
              user: UserModel(
                id: 'someId',
                email: 'someEmail',
                name: 'someName',
              ),
              authorization: 'someAuthorization',
            ),
          ),
        );
        verify(() => mockSecureStorage.read(any())).called(1);
      });

      test(
          'When user data is null on local Storage, should return UserNotFound failure',
          () async {
        when(
          () => mockSecureStorage.read(Constants.keyUserLoggedStored),
        ).thenAnswer(
          (_) async => null,
        );

        final response = await authRepository.getUserLogged();

        expect(response, Left(UserNotFound()));
        verify(() => mockSecureStorage.read(any())).called(1);
      });

      test(
          'When secure storage throws an Exception, should return UserNotFound failure',
          () async {
        when(
          () => mockSecureStorage.read(Constants.keyUserLoggedStored),
        ).thenThrow(PlatformException(code: 'someCode'));

        final response = await authRepository.getUserLogged();

        expect(response, Left(UserNotFound()));
        verify(() => mockSecureStorage.read(any())).called(1);
      });
    });

    group('Logout', () {
      test('Logout should delete user logged from secure storage', () async {
        when(() => mockSecureStorage.delete(Constants.keyUserLoggedStored))
            .thenAnswer((_) async => Void);

        final response = await authRepository.logout();

        // ignore: void_checks
        expect(response, const Right<Failure, void>(Void));
        verify(() => mockSecureStorage.delete(Constants.keyUserLoggedStored))
            .called(1);
      });

      test(
          'When logout throws exception, should return ErrorOnLocalStorage failure',
          () async {
        when(() => mockSecureStorage.delete(Constants.keyUserLoggedStored))
            .thenThrow(PlatformException(code: 'code'));

        final response = await authRepository.logout();

        expect(response, Left<Failure, void>(ErrorOnLocalStorage()));
        verify(() => mockSecureStorage.delete(Constants.keyUserLoggedStored))
            .called(1);
      });
    });

    group('saveUserLogged', () {
      test('Should transform userlogged is json and save on secure storage',
          () async {
        when(() =>
                mockSecureStorage.store(Constants.keyUserLoggedStored, any()))
            .thenAnswer((_) async => Void);

        final response = await authRepository.saveUserLogged(userLoggedEntity);

        // ignore: void_checks
        expect(response, const Right<Failure, void>(Void));
        verify(() =>
                mockSecureStorage.store(Constants.keyUserLoggedStored, any()))
            .called(1);
      });

      test(
          'When store throws exception, should return ErrorOnSaveLocalStorage failure',
          () async {
        when(() =>
                mockSecureStorage.store(Constants.keyUserLoggedStored, any()))
            .thenThrow(PlatformException(code: 'code'));

        final response = await authRepository.saveUserLogged(userLoggedEntity);

        expect(response, Left<Failure, void>(ErrorOnSaveLocalStorage()));
        verify(() =>
                mockSecureStorage.store(Constants.keyUserLoggedStored, any()))
            .called(1);
      });
    });

    group('login', () {
      test('Should call login method from AuthApi, passing email and password',
          () async {
        when(
          () => mockAuthApi.login(
            email: 'someEmail',
            password: 'somePassword',
          ),
        ).thenAnswer((_) async => userLoggedEntity);

        final response = await authRepository.login(loginEntity);

        verify(
          () => mockAuthApi.login(
            email: 'someEmail',
            password: 'somePassword',
          ),
        ).called(1);
        expect(response, const Right(userLoggedEntity));
      });

      test(
          'When email and password doesn\'t mismatch, should return UserNotFound failure',
          () async {
        when(
          () => mockAuthApi.login(
            email: 'someEmail',
            password: 'somePassword',
          ),
        ).thenAnswer((_) async => null);

        final response = await authRepository.login(loginEntity);

        verify(
          () => mockAuthApi.login(
            email: 'someEmail',
            password: 'somePassword',
          ),
        ).called(1);
        expect(response, Left<Failure, UserLoggedEntity>(UserNotFound()));
      });

      test(
          'When login throws an exception, should return ServerFailure failure',
          () async {
        when(
          () => mockAuthApi.login(
            email: 'someEmail',
            password: 'somePassword',
          ),
        ).thenThrow(Exception());

        final response = await authRepository.login(loginEntity);

        verify(
          () => mockAuthApi.login(
            email: 'someEmail',
            password: 'somePassword',
          ),
        ).called(1);
        expect(response, Left<Failure, UserLoggedEntity>(ServerFailure()));
      });
    });

    group('register', () {
      test(
          'Should call register method from AuthApi, passing email, name and password',
          () async {
        when(
          () => mockAuthApi.register(
            name: 'someName',
            email: 'someEmail',
            password: 'somePassword',
          ),
        ).thenAnswer((_) async => userLoggedEntity);

        final response = await authRepository.register(registerEntity);

        verify(
          () => mockAuthApi.register(
            name: 'someName',
            email: 'someEmail',
            password: 'somePassword',
          ),
        ).called(1);
        expect(response, const Right(userLoggedEntity));
      });

      test(
          'When register throws an exception, should return ServerFailure failure',
          () async {
        when(
          () => mockAuthApi.register(
            name: 'someName',
            email: 'someEmail',
            password: 'somePassword',
          ),
        ).thenThrow(Exception());

        final response = await authRepository.register(registerEntity);

        verify(
          () => mockAuthApi.register(
            name: 'someName',
            email: 'someEmail',
            password: 'somePassword',
          ),
        ).called(1);
        expect(response, Left<Failure, UserLoggedEntity>(ServerFailure()));
      });
    });
  });
}
