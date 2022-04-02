import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/src/app/bloc/app_state.dart';
import 'package:flutter_blog_app/src/core/usecase/usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required GetUserLoggedUseCase getUserLoggedUseCase,
    this.splashPageDuration = const Duration(seconds: 3),
  })  : _getUserLoggedUseCase = getUserLoggedUseCase,
        super(UnauthenticatedState());

  final GetUserLoggedUseCase _getUserLoggedUseCase;
  final Duration splashPageDuration;

  Future<void> checkUserLogged() async {
    await Future.delayed(splashPageDuration);
    final response = await _getUserLoggedUseCase.call(NoParams());

    response.fold((_) {
      emit(UnauthenticatedState());
      Modular.to.pushReplacementNamed('/auth/');
    }, (data) {
      emit(AuthenticatedState(userLoggedEntity: data));
      Modular.to.pushReplacementNamed('/home/');
    });
  }
}
