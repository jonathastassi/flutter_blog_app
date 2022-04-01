import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_blog_app/src/app/bloc/app_state.dart';
import 'package:flutter_blog_app/src/features/splash/presenter/view/splash_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, AppCubit> {
  @override
  void initState() {
    cubit.initialize();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.status == AppStatus.authenticated) {
          Modular.to.pushReplacementNamed('/auth/');
        } else {
          Modular.to.pushReplacementNamed('/home/');
        }
      },
      child: const SplashView(),
    );
  }
}
