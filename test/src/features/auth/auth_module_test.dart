import 'package:flutter/material.dart';
import 'package:flutter_blog_app/src/features/auth/auth_module.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/view/login_page.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/view/register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthModule', () {
    testWidgets('When / is called on route, should open LoginPage',
        (tester) async {
      await tester.pumpWidget(
        Builder(builder: (context) {
          Modular.setInitialRoute('/');

          return ModularApp(
            module: AuthModule(),
            child: MaterialApp.router(
              routeInformationParser: Modular.routeInformationParser,
              routerDelegate: Modular.routerDelegate,
            ),
          );
        }),
      );

      await tester.pump();

      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('When /register is called on route, should open RegisterPage',
        (tester) async {
      await tester.pumpWidget(
        Builder(builder: (context) {
          Modular.setInitialRoute('/register');

          return ModularApp(
            module: AuthModule(),
            child: MaterialApp.router(
              routeInformationParser: Modular.routeInformationParser,
              routerDelegate: Modular.routerDelegate,
            ),
          );
        }),
      );

      await tester.pump();

      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}
