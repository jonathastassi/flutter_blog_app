import 'package:flutter/material.dart';
import 'package:flutter_blog_app/src/core/navigation/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Blog App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          toolbarHeight: 62,
          backgroundColor: Color(0XFF009CA3),
        ),
      ),
      onGenerateRoute: AppRouter.onGeneratedRoutes,
    );
  }
}
