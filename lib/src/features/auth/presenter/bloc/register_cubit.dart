import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/register_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/usecases/do_register_usecase.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/register_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required DoRegisterUseCase doRegisterUseCase,
    required AppCubit appCubit,
  })  : _doRegisterUseCase = doRegisterUseCase,
        _appCubit = appCubit,
        super(const RegisterState());

  final DoRegisterUseCase _doRegisterUseCase;
  final AppCubit _appCubit;

  void setName(String name) => emit(state.copyWith(name: name, error: ''));

  void setEmail(String email) => emit(state.copyWith(email: email, error: ''));

  void setPassword(String password) =>
      emit(state.copyWith(password: password, error: ''));

  void setConfirmPassword(String confirmPassword) =>
      emit(state.copyWith(confirmPassword: confirmPassword, error: ''));

  void showLoading() => emit(state.copyWith(loading: true));

  void hideLoading() => emit(state.copyWith(loading: false));

  void setError(String error) => emit(state.copyWith(error: error));

  Future<void> register() async {
    setError('');
    showLoading();

    final response = await _doRegisterUseCase.call(
      RegisterEntity(
        name: state.name,
        email: state.email,
        password: state.password,
      ),
    );

    hideLoading();

    response.fold(
        (_) => setError(
            'Não foi possível criar a conta!\nPor favor, tente novamente.'),
        (data) {
      backToLogin();
      _appCubit.setUserLogged(data);
    });
  }

  void backToLogin() {
    Modular.to.pop();
  }
}
