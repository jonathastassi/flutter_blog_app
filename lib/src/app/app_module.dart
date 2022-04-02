import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/core/secure_storage/secure_storage.dart';
import 'package:flutter_blog_app/src/features/auth/auth_module.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_logout_usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:flutter_blog_app/src/features/auth/infra/datasources/auth_api.dart';
import 'package:flutter_blog_app/src/features/auth/infra/datasources/fake_auth_api_impl.dart';
import 'package:flutter_blog_app/src/features/auth/infra/repositories/auth_repository_impl.dart';
import 'package:flutter_blog_app/src/features/home/home_module.dart';
import 'package:flutter_blog_app/src/features/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<FlutterSecureStorage>((i) => const FlutterSecureStorage()),
    Bind.factory<SecureStorage>(
      (i) => SecureStorageImpl(
        flutterSecureStorage: i(),
      ),
    ),
    Bind.factory<AuthApi>((i) => FakeAuthApiImpl()),
    Bind.factory<AuthRepository>(
      (i) => AuthRepositoryImpl(
        authApi: i(),
        secureStorage: i(),
      ),
    ),
    Bind.factory<GetUserLoggedUseCase>(
      (i) => GetUserLoggedUseCase(
        authRepository: i(),
      ),
    ),
    Bind.factory<DoLogoutUseCase>(
      (i) => DoLogoutUseCase(
        authRepository: i(),
      ),
    ),
    Bind.singleton<AppCubit>(
      (i) => AppCubit(
        getUserLoggedUseCase: i(),
        doLogoutUseCase: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/home', module: HomeModule()),
  ];
}
