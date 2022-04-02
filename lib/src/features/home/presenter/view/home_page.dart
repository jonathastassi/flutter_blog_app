import 'package:flutter/material.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = Modular.get();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: cubit.logout,
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
