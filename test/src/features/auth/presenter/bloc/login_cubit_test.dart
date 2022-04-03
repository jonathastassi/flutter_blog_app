import 'dart:ffi';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/core/errors/failures.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_login_usecase.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/login_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/login_state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppCubit extends Mock implements AppCubit {}

class MockDoLoginUseCase extends Mock implements DoLoginUseCase {}

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  group('LoginCubit', () {
    late AppCubit mockAppCubit;
    late DoLoginUseCase mockDoLoginUseCase;

    final navigate = ModularNavigateMock();
    Modular.navigatorDelegate = navigate;

    setUpAll(() {
      registerFallbackValue(
        const LoginEntity(
          email: 'someEmail',
          password: 'somePassword',
        ),
      );
    });

    setUp(() {
      mockAppCubit = MockAppCubit();
      mockDoLoginUseCase = MockDoLoginUseCase();
    });

    blocTest<LoginCubit, LoginState>(
      'When setEmail is called, should emits a new email and error is cleaned',
      build: () => LoginCubit(
        appCubit: mockAppCubit,
        doLoginUseCase: mockDoLoginUseCase,
      ),
      seed: () => const LoginState(error: 'someError'),
      act: (cubit) => cubit.setEmail('someEmail'),
      expect: () => const <LoginState>[
        LoginState(
          email: 'someEmail',
          error: '',
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'When setPassword is called, should emits a new password and error is cleaned',
      build: () => LoginCubit(
        appCubit: mockAppCubit,
        doLoginUseCase: mockDoLoginUseCase,
      ),
      seed: () => const LoginState(error: 'someError'),
      act: (cubit) => cubit.setPassword('somePassword'),
      expect: () => const <LoginState>[
        LoginState(
          password: 'somePassword',
          error: '',
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'When showLoading is called, should emits a loading true',
      build: () => LoginCubit(
        appCubit: mockAppCubit,
        doLoginUseCase: mockDoLoginUseCase,
      ),
      seed: () => const LoginState(loading: false),
      act: (cubit) => cubit.showLoading(),
      expect: () => const <LoginState>[
        LoginState(
          loading: true,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'When hideLoading is called, should emits a loading false',
      build: () => LoginCubit(
        appCubit: mockAppCubit,
        doLoginUseCase: mockDoLoginUseCase,
      ),
      seed: () => const LoginState(loading: true),
      act: (cubit) => cubit.hideLoading(),
      expect: () => const <LoginState>[
        LoginState(
          loading: false,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'When setError is called, should emits a new error',
      build: () => LoginCubit(
        appCubit: mockAppCubit,
        doLoginUseCase: mockDoLoginUseCase,
      ),
      act: (cubit) => cubit.setError('someError'),
      expect: () => const <LoginState>[
        LoginState(
          error: 'someError',
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'When login is successful, should emits [setError], [showLoading] and [hideLoading]',
      setUp: () {
        when(
          () => mockDoLoginUseCase.call(any()),
        ).thenAnswer(
          (_) async => const Right(
            UserLoggedEntity(
              authorization: 'someAuthorization',
              user: UserEntity(
                id: 'id',
                email: 'someEmail',
                name: 'someEmail',
              ),
            ),
          ),
        );
      },
      build: () => LoginCubit(
        appCubit: mockAppCubit,
        doLoginUseCase: mockDoLoginUseCase,
      ),
      seed: () => const LoginState(
        email: 'someEmail',
        password: 'somePassword',
        error: 'someError',
      ),
      act: (cubit) => cubit.login(),
      expect: () => const <LoginState>[
        LoginState(
          email: 'someEmail',
          password: 'somePassword',
          error: '',
        ),
        LoginState(
          email: 'someEmail',
          password: 'somePassword',
          error: '',
          loading: true,
        ),
        LoginState(
          email: 'someEmail',
          password: 'somePassword',
          error: '',
          loading: false,
        ),
      ],
      verify: (_) {
        verify(() => mockDoLoginUseCase.call(any())).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'When login have an error, should emits [setError], [showLoading], [hideLoading] and [setError]',
      setUp: () {
        when(
          () => mockDoLoginUseCase.call(any()),
        ).thenAnswer(
          (_) async => Left(
            UserNotFound(),
          ),
        );
      },
      build: () => LoginCubit(
        appCubit: mockAppCubit,
        doLoginUseCase: mockDoLoginUseCase,
      ),
      seed: () => const LoginState(
        email: 'someEmail',
        password: 'somePassword',
        error: 'someError',
      ),
      act: (cubit) => cubit.login(),
      expect: () => const <LoginState>[
        LoginState(
          email: 'someEmail',
          password: 'somePassword',
          error: '',
        ),
        LoginState(
          email: 'someEmail',
          password: 'somePassword',
          error: '',
          loading: true,
        ),
        LoginState(
          email: 'someEmail',
          password: 'somePassword',
          error: '',
          loading: false,
        ),
        LoginState(
          email: 'someEmail',
          password: 'somePassword',
          error: 'E-mail ou senha incorretos!',
        ),
      ],
      verify: (_) {
        verify(() => mockDoLoginUseCase.call(any())).called(1);
      },
    );

    test('register should redirect to /auth/register', () {
      when(() => navigate.pushNamed('/auth/register'))
          .thenAnswer((_) async => Void);

      final cubit = LoginCubit(
        appCubit: mockAppCubit,
        doLoginUseCase: mockDoLoginUseCase,
      );

      cubit.register();

      verify(() => navigate.pushNamed('/auth/register'));
    });
  });
}
