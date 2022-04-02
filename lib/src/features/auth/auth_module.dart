import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_login_usecase.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/login_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/view/login_page.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/view/register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<DoLoginUseCase>(
      (i) => DoLoginUseCase(
        authRepository: i(),
      ),
    ),
    Bind.singleton<LoginCubit>(
      (i) => LoginCubit(
        appCubit: i(),
        doLoginUseCase: i(),
      ),
    ),
  ];

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
