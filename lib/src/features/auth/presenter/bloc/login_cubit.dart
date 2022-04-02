import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_login_usecase.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/login_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required DoLoginUseCase doLoginUseCase,
    required AppCubit appCubit,
  })  : _doLoginUseCase = doLoginUseCase,
        _appCubit = appCubit,
        super(const LoginState());

  final DoLoginUseCase _doLoginUseCase;
  final AppCubit _appCubit;

  void setEmail(String email) => emit(state.copyWith(email: email, error: ''));

  void setPassword(String password) =>
      emit(state.copyWith(password: password, error: ''));

  void showLoading() => emit(state.copyWith(loading: true));

  void hideLoading() => emit(state.copyWith(loading: false));

  void setError(String error) => emit(state.copyWith(error: error));

  Future<void> login() async {
    setError('');
    showLoading();

    final response = await _doLoginUseCase.call(
      LoginEntity(
        email: state.email,
        password: state.password,
      ),
    );

    hideLoading();

    response.fold(
      (_) => setError('E-mail ou senha incorretos!'),
      (data) => _appCubit.setUserLogged(data),
    );
  }

  void register() {
    Modular.to.pushNamed('/auth/register');
  }
}
