import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/app/bloc/app_state.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUserLoggedUseCase extends Mock implements GetUserLoggedUseCase {}

void main() {
  group('AppCubit', () {
    late GetUserLoggedUseCase mockGetUserLoggedUseCase;

    setUp(() {
      mockGetUserLoggedUseCase = MockGetUserLoggedUseCase();
    });

    test('initial state is unauthenticatedState', () {
      expect(
        AppCubit(getUserLoggedUseCase: mockGetUserLoggedUseCase).state,
        UnauthenticatedState(),
      );
    });
  });
}
