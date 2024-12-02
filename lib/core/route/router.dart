import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../features/intro/presentation/splash_screen.dart';
import '../../features/quiz/presentation/screens/home_screen.dart';
import '../../features/quiz/presentation/screens/quiz_screen.dart';

class Routes {
  static const String splash = "splash";
  static const String home = "/";
  static const String quizScreen = "/quizScreen";


  static String currentRoute = splash;

  static Route<dynamic> onGenerateRouted(RouteSettings routeSettings) {
    currentRoute = routeSettings.name ?? "";
    if (kDebugMode) {
      print("Route: $currentRoute");
    }
    switch (routeSettings.name) {
      case splash:
        {
          return SplashScreen.route(routeSettings);
        }
      case home:
        {
          return HomeScreen.route(routeSettings);
        }
      case quizScreen:
        {
          return QuizScreen.route(routeSettings);
        }
      default:
        {
          return MaterialPageRoute(builder: (context) => const Scaffold());
        }
    }
  }
}
