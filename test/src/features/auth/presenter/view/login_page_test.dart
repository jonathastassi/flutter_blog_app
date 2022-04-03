import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/src/app/app_module.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/auth_module.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/login_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/login_state.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/view/login_page.dart';
import 'package:flutter_blog_app/src/shared/widgets/outlined_button_custom.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class MockAppCubit extends Mock implements AppCubit {}

class MockLoginCubit extends Mock implements LoginCubit {}

void main() {
  group('LoginPage', () {
    late AppCubit mockAppCubit;
    late LoginCubit mockLoginCubit;
    late Stream<LoginState> mockStreamLoginState;
    late StreamController<LoginState> mockStreamController;

    setUpAll(() {
      mockAppCubit = MockAppCubit();
      mockLoginCubit = MockLoginCubit();
      mockStreamController = StreamController<LoginState>.broadcast();
      mockStreamLoginState = mockStreamController.stream;
      initModules([
        AppModule(),
        AuthModule(),
      ], replaceBinds: [
        Bind.instance<AppCubit>(mockAppCubit),
        Bind.instance<LoginCubit>(mockLoginCubit),
      ]);

      when(() => mockLoginCubit.login()).thenAnswer((_) async => Void);
      when(() => mockLoginCubit.state).thenReturn(const LoginState());
      when(() => mockLoginCubit.stream).thenAnswer(
        (_) => mockStreamLoginState,
      );

      mockStreamController.sink.add(const LoginState(error: ''));
    });

    tearDownAll(() {
      mockStreamController.close();
    });

    testWidgets('Should show message when have error on cubit', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );

      mockStreamController.sink.add(const LoginState(error: 'someError'));

      await tester.pump();

      final errorMessage = find.text('someError');
      expect(errorMessage, findsOneWidget);
    });

    testWidgets('When form is invalid, deny call bloc.login', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );

      final buttonLogin = find.widgetWithText(OutlinedButtonCustom, 'Acessar');

      await tester.tap(buttonLogin);

      await tester.pump();

      verifyNever(() => mockLoginCubit.login());
    });

    testWidgets('When form is valid, allow call bloc.login', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );

      final buttonLogin = find.widgetWithText(OutlinedButtonCustom, 'Acessar');

      await tester.enterText(
          find.byKey(const Key('loginPage_email')), 'someemail@email.com');
      await tester.enterText(
          find.byKey(const Key('loginPage_password')), 'somePassword');

      await tester.tap(buttonLogin);

      await tester.pump();

      verify(() => mockLoginCubit.login()).called(1);
    });
  });
}
