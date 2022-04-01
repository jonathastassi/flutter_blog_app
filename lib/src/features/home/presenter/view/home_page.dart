import 'package:flutter/material.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Text(context.read<AppCubit>().userLogged != null
          ? context.read<AppCubit>().userLogged!.user.name
          : "No user"),
    );
  }
}
