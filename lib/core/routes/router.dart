import 'package:flutter/material.dart';
import 'package:taskify/presentation/pages/home/home_page.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomeWidget());
      default:
        return MaterialPageRoute(builder: (context) => HomeWidget());
    }
  }
}
