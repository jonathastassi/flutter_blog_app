import 'dart:ffi';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/src/app/app_module.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/app/bloc/app_state.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:flutter_blog_app/src/features/splash/presenter/view/splash_page.dart';
import 'package:flutter_blog_app/src/features/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

class MockStream extends Mock implements Stream<AppState> {}

class ModularNavigateMock extends Mock implements IModularNavigator {}

class MockGetUserLoggedUseCase extends Mock implements GetUserLoggedUseCase {}

void main() {
  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;

  group('SplashPage', () {
    late AppCubit mockAppCubit;

    testWidgets('Should call initialize of cubit on initState', (tester) async {
      mockAppCubit = MockAppCubit();
      initModule(
        AppModule(),
        replaceBinds: [
          Bind.instance<AppCubit>(mockAppCubit),
        ],
      );

      when(() => mockAppCubit.state).thenReturn(UnauthenticatedState());
      when(() => mockAppCubit.checkUserLogged()).thenAnswer((_) async => Void);

      await tester.pumpWidget(
        const MaterialApp(
          home: SplashPage(),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      verify(() => mockAppCubit.checkUserLogged()).called(1);
    });
  });
}
