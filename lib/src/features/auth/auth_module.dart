import 'package:flutter_blog_app/src/features/auth/presenter/view/login_page.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/view/register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const LoginPage(),
    ),
    ChildRoute(
      '/register',
      child: (context, args) => const RegisterPage(),
    ),
  ];
}
