import 'dart:ffi';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_blog_app/src/app/app_module.dart';
import 'package:flutter_blog_app/src/app/app_widget.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/app/bloc/app_state.dart';
import 'package:flutter_blog_app/src/features/splash/presenter/view/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

void main() {
  group('SplashModule', () {
    testWidgets('When / is called on route, should open SplashPage',
        (tester) async {
      late AppCubit mockAppCubit = MockAppCubit();
      initModule(
        AppModule(),
        replaceBinds: [
          Bind.instance<AppCubit>(mockAppCubit),
        ],
      );

      when(() => mockAppCubit.state)
          .thenReturn(const AppState.unauthenticated());
      when(() => mockAppCubit.checkUserLogged()).thenAnswer((_) async => Void);

      await tester.pumpWidget(
        ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      Modular.to.pushReplacementNamed(Modular.initialRoute);

      await tester.pump(const Duration(seconds: 3));

      expect(find.byType(SplashPage), findsOneWidget);
    });
  });
}
