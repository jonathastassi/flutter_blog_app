import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/src/app/bloc/app_state.dart';
import 'package:flutter_blog_app/src/core/usecase/usecase.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/get_user_logged_usecase.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required GetUserLoggedUseCase getUserLoggedUseCase,
  })  : _getUserLoggedUseCase = getUserLoggedUseCase,
        super(const AppState.unauthenticated());

  final GetUserLoggedUseCase _getUserLoggedUseCase;

  UserLoggedEntity? get userLogged => state.userLoggedEntity;

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await _getUserLoggedUseCase.call(NoParams());

    response.fold(
      (_) => emit(
        const AppState.unauthenticated(),
      ),
      (data) => emit(
        AppState.authenticated(data),
      ),
    );
  }
}
