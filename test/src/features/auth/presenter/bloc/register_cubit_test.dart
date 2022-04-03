import 'dart:ffi';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/core/errors/failures.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/register_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_register_usecase.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/register_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/register_state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppCubit extends Mock implements AppCubit {}

class MockDoRegisterUseCase extends Mock implements DoRegisterUseCase {}

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  group('RegisterCubit', () {
    late AppCubit mockAppCubit;
    late DoRegisterUseCase mockDoRegisterUseCase;

    final navigate = ModularNavigateMock();
    Modular.navigatorDelegate = navigate;

    setUpAll(() {
      registerFallbackValue(
        const RegisterEntity(
          name: 'someName',
          email: 'someEmail',
          password: 'somePassword',
        ),
      );
    });

    setUp(() {
      mockAppCubit = MockAppCubit();
      mockDoRegisterUseCase = MockDoRegisterUseCase();
    });

    blocTest<RegisterCubit, RegisterState>(
      'When setEmail is called, should emits a new email and error is cleaned',
      build: () => RegisterCubit(
        appCubit: mockAppCubit,
        doRegisterUseCase: mockDoRegisterUseCase,
      ),
      seed: () => const RegisterState(error: 'someError'),
      act: (cubit) => cubit.setEmail('someEmail'),
      expect: () => const <RegisterState>[
        RegisterState(
          email: 'someEmail',
          error: '',
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'When setName is called, should emits a new name and error is cleaned',
      build: () => RegisterCubit(
        appCubit: mockAppCubit,
        doRegisterUseCase: mockDoRegisterUseCase,
      ),
      seed: () => const RegisterState(error: 'someError'),
      act: (cubit) => cubit.setName('someName'),
      expect: () => const <RegisterState>[
        RegisterState(
          name: 'someName',
          error: '',
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'When setPassword is called, should emits a new password and error is cleaned',
      build: () => RegisterCubit(
        appCubit: mockAppCubit,
        doRegisterUseCase: mockDoRegisterUseCase,
      ),
      seed: () => const RegisterState(error: 'someError'),
      act: (cubit) => cubit.setPassword('somePassword'),
      expect: () => const <RegisterState>[
        RegisterState(
          password: 'somePassword',
          error: '',
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'When setConfirmPassword is called, should emits a new confirmPassword and error is cleaned',
      build: () => RegisterCubit(
        appCubit: mockAppCubit,
        doRegisterUseCase: mockDoRegisterUseCase,
      ),
      seed: () => const RegisterState(error: 'someError'),
      act: (cubit) => cubit.setConfirmPassword('somePassword'),
      expect: () => const <RegisterState>[
        RegisterState(
          confirmPassword: 'somePassword',
          error: '',
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'When showLoading is called, should emits a loading true',
      build: () => RegisterCubit(
        appCubit: mockAppCubit,
        doRegisterUseCase: mockDoRegisterUseCase,
      ),
      seed: () => const RegisterState(loading: false),
      act: (cubit) => cubit.showLoading(),
      expect: () => const <RegisterState>[
        RegisterState(
          loading: true,
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'When hideLoading is called, should emits a loading false',
      build: () => RegisterCubit(
        appCubit: mockAppCubit,
        doRegisterUseCase: mockDoRegisterUseCase,
      ),
      seed: () => const RegisterState(loading: true),
      act: (cubit) => cubit.hideLoading(),
      expect: () => const <RegisterState>[
        RegisterState(
          loading: false,
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'When setError is called, should emits a new error',
      build: () => RegisterCubit(
        appCubit: mockAppCubit,
        doRegisterUseCase: mockDoRegisterUseCase,
      ),
      act: (cubit) => cubit.setError('someError'),
      expect: () => const <RegisterState>[
        RegisterState(
          error: 'someError',
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'When register is successful, should emits [setError], [showLoading] and [hideLoading]',
      setUp: () {
        when(
          () => mockDoRegisterUseCase.call(any()),
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
      build: () => RegisterCubit(
        appCubit: mockAppCubit,
        doRegisterUseCase: mockDoRegisterUseCase,
      ),
      seed: () => const RegisterState(
        name: 'someName',
        email: 'someEmail',
        password: 'somePassword',
        error: 'someError',
      ),
      act: (cubit) => cubit.register(),
      expect: () => const <RegisterState>[
        RegisterState(
          name: 'someName',
          email: 'someEmail',
          password: 'somePassword',
          error: '',
        ),
        RegisterState(
          name: 'someName',
          email: 'someEmail',
          password: 'somePassword',
          error: '',
          loading: true,
        ),
        RegisterState(
          name: 'someName',
          email: 'someEmail',
          password: 'somePassword',
          error: '',
          loading: false,
        ),
      ],
      verify: (_) {
        verify(() => mockDoRegisterUseCase.call(any())).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      'When register have an error, should emits [setError], [showLoading], [hideLoading] and [setError]',
      setUp: () {
        when(
          () => mockDoRegisterUseCase.call(any()),
        ).thenAnswer(
          (_) async => Left(
            ServerFailure(),
          ),
        );
      },
      build: () => RegisterCubit(
        appCubit: mockAppCubit,
        doRegisterUseCase: mockDoRegisterUseCase,
      ),
      seed: () => const RegisterState(
        name: 'someName',
        email: 'someEmail',
        password: 'somePassword',
        error: 'someError',
      ),
      act: (cubit) => cubit.register(),
      expect: () => const <RegisterState>[
        RegisterState(
          name: 'someName',
          email: 'someEmail',
          password: 'somePassword',
          error: '',
        ),
        RegisterState(
          name: 'someName',
          email: 'someEmail',
          password: 'somePassword',
          error: '',
          loading: true,
        ),
        RegisterState(
          name: 'someName',
          email: 'someEmail',
          password: 'somePassword',
          error: '',
          loading: false,
        ),
        RegisterState(
          name: 'someName',
          email: 'someEmail',
          password: 'somePassword',
          error: 'Não foi possível criar a conta!\nPor favor, tente novamente.',
        ),
      ],
      verify: (_) {
        verify(() => mockDoRegisterUseCase.call(any())).called(1);
      },
    );

    test('backToLogin should redirect to /auth/ [pop]', () {
      when(() => navigate.pop()).thenAnswer((_) async => Void);

      final cubit = RegisterCubit(
        appCubit: mockAppCubit,
        doRegisterUseCase: mockDoRegisterUseCase,
      );

      cubit.backToLogin();

      verify(() => navigate.pop());
    });
  });
}
