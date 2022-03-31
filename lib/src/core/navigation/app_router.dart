import 'package:flutter/material.dart';
import 'package:flutter_blog_app/src/features/splash/presenter/splash_page.dart';

class AppRouter {
  static Route<dynamic> onGeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}
