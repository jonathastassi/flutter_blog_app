import 'package:flutter/material.dart';
import 'package:flutter_blog_app/src/app/theme/app_theme.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Flutter Blog App',
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
