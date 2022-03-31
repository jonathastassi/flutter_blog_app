import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/core/usecase/usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_logout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('DoLogoutUseCase', () {
    late DoLogoutUseCase doLogoutUseCase;
    late AuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      doLogoutUseCase = DoLogoutUseCase(
        authRepository: mockAuthRepository,
      );
    });

    test('On call, should execute logout from auth repository', () async {
      when(() => mockAuthRepository.logout()).thenAnswer(
        // ignore: void_checks
        (_) async => const Right(Void),
      );

      await doLogoutUseCase.call(NoParams());

      verify(() => mockAuthRepository.logout()).called(1);
    });
  });
}
