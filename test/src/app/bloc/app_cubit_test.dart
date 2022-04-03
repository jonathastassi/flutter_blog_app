import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/app/bloc/app_state.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_logout_usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUserLoggedUseCase extends Mock implements GetUserLoggedUseCase {}

class MockDoLogoutUseCase extends Mock implements DoLogoutUseCase {}

void main() {
  group('AppCubit', () {
    late GetUserLoggedUseCase mockGetUserLoggedUseCase;
    late DoLogoutUseCase mockDoLogoutUseCase;

    setUp(() {
      mockGetUserLoggedUseCase = MockGetUserLoggedUseCase();
      mockDoLogoutUseCase = MockDoLogoutUseCase();
    });

    test('initial state is unauthenticatedState', () {
      expect(
        AppCubit(
          getUserLoggedUseCase: mockGetUserLoggedUseCase,
          doLogoutUseCase: mockDoLogoutUseCase,
        ).state,
        UnauthenticatedState(),
      );
    });
  });
}
