import 'package:flutter/material.dart';
import 'package:taskify/presentation/pages/home/home_page.dart';
import 'package:taskify/presentation/pages/splash/splash_page.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/splash':
        return MaterialPageRoute(builder: (context) => SplashPage());
      default:
        return MaterialPageRoute(builder: (context) => HomePage());
    }
  }
}
