import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/src/app/app_module.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/auth_module.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/register_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/register_state.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/view/register_page.dart';
import 'package:flutter_blog_app/src/shared/widgets/outlined_button_custom.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class MockAppCubit extends Mock implements AppCubit {}

class MockRegisterCubit extends Mock implements RegisterCubit {}

void main() {
  group('RegisterPage', () {
    late AppCubit mockAppCubit;
    late RegisterCubit mockRegisterCubit;
    late Stream<RegisterState> mockStreamRegisterState;
    late StreamController<RegisterState> mockStreamController;

    setUpAll(() {
      mockAppCubit = MockAppCubit();
      mockRegisterCubit = MockRegisterCubit();
      mockStreamController = StreamController<RegisterState>.broadcast();
      mockStreamRegisterState = mockStreamController.stream;
      initModules([
        AppModule(),
        AuthModule(),
      ], replaceBinds: [
        Bind.instance<AppCubit>(mockAppCubit),
        Bind.instance<RegisterCubit>(mockRegisterCubit),
      ]);

      when(() => mockRegisterCubit.register()).thenAnswer((_) async => Void);
      when(() => mockRegisterCubit.state).thenReturn(const RegisterState());
      when(() => mockRegisterCubit.stream).thenAnswer(
        (_) => mockStreamRegisterState,
      );

      mockStreamController.sink.add(const RegisterState(error: ''));
    });

    tearDownAll(() {
      mockStreamController.close();
    });

    testWidgets('Should show message when have error on cubit', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterPage(),
        ),
      );

      mockStreamController.sink.add(const RegisterState(error: 'someError'));

      await tester.pump();

      final errorMessage = find.text('someError');
      expect(errorMessage, findsOneWidget);
    });

    testWidgets('When form is invalid, deny call bloc.login', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterPage(),
        ),
      );

      final buttonRegister =
          find.widgetWithText(OutlinedButtonCustom, 'Criar conta');

      await tester.tap(buttonRegister);

      await tester.pump();

      verifyNever(() => mockRegisterCubit.register());
    });

    testWidgets('When form is valid, allow call bloc.register', (tester) async {
      when(() => mockRegisterCubit.state).thenReturn(
        const RegisterState(
            name: 'someName',
            email: 'someemail@email.com',
            password: 'somePassword',
            confirmPassword: 'somePassword'),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterPage(),
        ),
      );

      final buttonRegister =
          find.widgetWithText(OutlinedButtonCustom, 'Criar conta');

      await tester.enterText(
          find.byKey(const Key('registerPage_email')), 'someemail@email.com');
      await tester.enterText(
          find.byKey(const Key('registerPage_name')), 'someName');
      await tester.enterText(
          find.byKey(const Key('registerPage_password')), 'somePassword');
      await tester.enterText(
          find.byKey(const Key('registerPage_confirmPassword')),
          'somePassword');

      await tester.tap(buttonRegister);

      await tester.pump();

      verify(() => mockRegisterCubit.register()).called(1);
    });
  });
}
