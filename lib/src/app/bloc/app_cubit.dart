import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/src/app/bloc/app_state.dart';
import 'package:flutter_blog_app/src/core/usecase/usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_logout_usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required GetUserLoggedUseCase getUserLoggedUseCase,
    required DoLogoutUseCase doLogoutUseCase,
    this.splashPageDuration = const Duration(seconds: 3),
  })  : _getUserLoggedUseCase = getUserLoggedUseCase,
        _doLogoutUseCase = doLogoutUseCase,
        super(UnauthenticatedState());

  final GetUserLoggedUseCase _getUserLoggedUseCase;
  final DoLogoutUseCase _doLogoutUseCase;
  final Duration splashPageDuration;

  Future<void> checkUserLogged() async {
    await Future.delayed(splashPageDuration);
    final response = await _getUserLoggedUseCase.call(NoParams());

    response.fold((_) {
      emit(UnauthenticatedState());
      Modular.to.pushReplacementNamed('/auth/');
    }, (data) {
      setUserLogged(data);
    });
  }

  void setUserLogged(UserLoggedEntity userLoggedEntity) {
    emit(AuthenticatedState(userLoggedEntity: userLoggedEntity));
    Modular.to.pushReplacementNamed('/home/');
  }

  Future<void> logout() async {
    await _doLogoutUseCase.call(NoParams());
    Modular.to.pushReplacementNamed('/auth/');
  }
}
